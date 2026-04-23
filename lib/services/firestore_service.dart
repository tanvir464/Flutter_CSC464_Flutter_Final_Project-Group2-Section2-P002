import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/match_record.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;
  static const _collection = 'matches';

  /// Saves a completed match and returns the generated document ID.
  Future<String> saveMatch(MatchRecord record) async {
    final ref = await _db.collection(_collection).add(record.toMap());
    return ref.id;
  }

  /// Returns matches ordered newest-first, capped at [limit] documents.
  Future<List<MatchRecord>> fetchMatches({int limit = 50}) async {
    final snapshot = await _db
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return snapshot.docs.map(MatchRecord.fromFirestore).toList();
  }
}
