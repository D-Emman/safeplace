import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../services/firestore_service.dart';
import '../models/post_model.dart';


part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final FirestoreService _fs = FirestoreService();

  PostsCubit() : super(PostsInitial());

  Stream<List<PostModel>> watchFeed({int limit = 25}) {
    return _fs.streamPosts(limit: limit);
  }

  Future<void> createPost({required String userId, required String username, required String content, List<String>? tags}) async {
    try {
      emit(PostsLoading());
      final post = PostModel(
        id: '',
        userId: userId,
        username: username,
        content: content,
        tags: tags ?? [],
        supportCount: 0,
        timestamp: DateTime.now(),
        isReported: false,
      );
      await _fs.createPost(post);
      emit(PostsSuccess());
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  Future<void> supportPost(String postId, String userId) async {
    try {
      await _fs.supportPost(postId, userId);
      // optimistic UI handled by Firestore snapshot update
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  Future<void> report(String collection, String docId, String reason) async {
    try {
      await _fs.reportContent(collection, docId, reason);
      emit(PostsReported());
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}
