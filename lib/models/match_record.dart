import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory MatchRecord.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MatchRecord(
      id: doc.id,
      player1: data['player1'] as String,
      player2: data['player2'] as String,
      winner: data['winner'] as String,
      board: List<String>.from(data['board'] as List),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'player1': player1,
        'player2': player2,
        'winner': winner,
        'board': board,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}
