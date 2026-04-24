import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/match_record.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;
  static const _collection = 'matches';

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  /// Saves a completed match, scoped to the currently signed-in user.
  /// Returns the generated document ID, or null if no user is signed in.
  Future<String?> saveMatch(MatchRecord record) async {
    final uid = _uid;
    if (uid == null) return null;
    final payload = {...record.toMap(), 'userId': uid};
    final ref = await _db.collection(_collection).add(payload);
    return ref.id;
  }

  /// Returns matches for the currently signed-in user, newest-first.
  Future<List<MatchRecord>> fetchMatches({int limit = 50}) async {
    final uid = _uid;
    if (uid == null) return [];
    final snapshot = await _db
        .collection(_collection)
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return snapshot.docs.map(MatchRecord.fromFirestore).toList();
  }
}
