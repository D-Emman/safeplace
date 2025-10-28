import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants.dart';
import '../models/post_model.dart';

class FirestoreService {
  final FirebaseFirestore _fs = FirebaseFirestore.instance;

  Stream<List<PostModel>> streamPosts({int limit = 20}) {

    return _fs
        .collection(postsCollection)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => PostModel.fromMap(d.id, d.data())).toList());
  }

  Future<void> createPost(PostModel post) async {
    await _fs.collection(postsCollection).add(post.toMap());
  }

  Future<void> supportPost(String postId, String userId) async {
    final doc = _fs.collection(postsCollection).doc(postId);
    await _fs.runTransaction((tx) async {
      final snapshot = await tx.get(doc);
      final current = snapshot.data()?['supportCount'] ?? 0;
      tx.update(doc, {'supportCount': current + 1});
    });
  }

  Future<void> reportContent(
      String collection, String docId, String reason) async {
    final ref = _fs.collection(collection).doc(docId);
    await ref.update({
      'isReported': true,
      'reportedAt': FieldValue.serverTimestamp(),
      'reportReason': reason

    });
// optionally write to a moderation queue
  }
}
