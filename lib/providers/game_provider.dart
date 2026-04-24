import 'package:flutter/foundation.dart';
import '../models/game_state.dart';
import '../models/match_record.dart';
import '../services/firestore_service.dart';

const List<List<int>> _kWinLines = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
  [0, 3, 6], [1, 4, 7], [2, 5, 8], // cols
  [0, 4, 8], [2, 4, 6],             // diagonals
];

class GameProvider extends ChangeNotifier {
  final FirestoreService _firestoreService;

  GameProvider(this._firestoreService);

  // Player identities
  String player1Name = 'Player 1'; // always X
  String player2Name = 'Player 2'; // always O

  // Board: 9 cells, values '', 'X', 'O'
  List<String> board = List.filled(9, '');

  // Turn & flow
  Player currentPlayer = Player.X;
  Player startingPlayer = Player.X;
  GameStatus status = GameStatus.idle;

  // Result
  String? winner; // 'X', 'O', or 'Tie'
  List<int> winningIndices = [];

  // Session scoreboard
  int xWins = 0;
  int oWins = 0;
  int ties = 0;

  bool isLoading = false;

  // ── Public API ──────────────────────────────────────────────────────────────

  String get currentPlayerName =>
      currentPlayer == Player.X ? player1Name : player2Name;

  void setPlayerNames(String p1, String p2) {
    player1Name = p1.trim().isEmpty ? 'Player 1' : p1.trim();
    player2Name = p2.trim().isEmpty ? 'Player 2' : p2.trim();
    _resetBoard();
    status = GameStatus.inProgress;
    notifyListeners();
  }

  void makeMove(int index) {
    if (status != GameStatus.inProgress) return;
    if (board[index].isNotEmpty) return;

    board[index] = currentPlayer == Player.X ? 'X' : 'O';

    if (_checkWinner()) {
      winner = currentPlayer == Player.X ? 'X' : 'O';
      status = GameStatus.won;
      if (winner == 'X') {
        xWins++;
      } else {
        oWins++;
      }
      _saveMatch();
    } else if (_checkTie()) {
      winner = 'Tie';
      status = GameStatus.tied;
      ties++;
      _saveMatch();
    } else {
      currentPlayer =
          currentPlayer == Player.X ? Player.O : Player.X;
    }
    notifyListeners();
  }

  void resetBoard() {
    _resetBoard();
    status = GameStatus.inProgress;
    notifyListeners();
  }

  void switchStartingPlayer() {
    startingPlayer =
        startingPlayer == Player.X ? Player.O : Player.X;
    resetBoard();
  }

  void resetAll() {
    player1Name = 'Player 1';
    player2Name = 'Player 2';
    startingPlayer = Player.X;
    xWins = 0;
    oWins = 0;
    ties = 0;
    _resetBoard();
    status = GameStatus.idle;
    notifyListeners();
  }

  // ── Private helpers ─────────────────────────────────────────────────────────

  void _resetBoard() {
    board = List.filled(9, '');
    currentPlayer = startingPlayer;
    winner = null;
    winningIndices = [];
  }

  bool _checkWinner() {
    final mark = currentPlayer == Player.X ? 'X' : 'O';
    for (final line in _kWinLines) {
      if (board[line[0]] == mark &&
          board[line[1]] == mark &&
          board[line[2]] == mark) {
        winningIndices = line;
        return true;
      }
    }
    return false;
  }

  bool _checkTie() => board.every((cell) => cell.isNotEmpty);

  Future<void> _saveMatch() async {
    isLoading = true;
    notifyListeners();
    try {
      final record = MatchRecord(
        id: '',
        userId: '',
        player1: player1Name,
        player2: player2Name,
        winner: winner!,
        board: List<String>.from(board),
        createdAt: DateTime.now(),
      );
      await _firestoreService.saveMatch(record);
    } catch (_) {
      // silently ignore save errors
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
