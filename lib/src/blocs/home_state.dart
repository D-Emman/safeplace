part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final String message;
  final String advice;
  HomeLoaded({required this.message, required this.advice});
  @override
  List<Object?> get props => [message, advice];
}
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
  @override
  List<Object?> get props => [message];
}
class HomeStreakUpdated extends HomeState {
  final int streak;
  HomeStreakUpdated(this.streak);
  @override
  List<Object?> get props => [streak];
}
