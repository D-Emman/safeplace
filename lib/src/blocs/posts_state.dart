part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}
class PostsLoading extends PostsState {}
class PostsSuccess extends PostsState {}
class PostsReported extends PostsState {}
class PostsError extends PostsState {
  final String message;
  PostsError(this.message);
  @override
  List<Object?> get props => [message];
}
