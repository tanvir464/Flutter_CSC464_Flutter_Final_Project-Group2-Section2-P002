class MatchRecord {
  final String id;
  final String player1;
  final String player2;
  final String winner; // "X", "O", or "Tie"
  final List<String> board;
  final DateTime createdAt;

  MatchRecord({
    required this.id,
    required this.player1,
    required this.player2,
    required this.winner,
    required this.board,
    required this.createdAt,
  });
}
