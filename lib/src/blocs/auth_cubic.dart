import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';


part 'auth_state.dart'

class AuthCubit extends Cubit<AuthState> {
  final AuthService _service = AuthService();


  AuthCubit() : super(AuthInitial());


  Future<void> checkAuth() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) emit(Authenticated(user));
    else emit(Unauthenticated());
  }


  Future<void> register(String email, String password) async {
    try {
      emit(AuthLoading());
      final cred = await _service.registerWithEmail(email: email, password: password);
      emit(Authenticated(cred.user!));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }


  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final cred = await _service.login(email: email, password: password);
      emit(Authenticated(cred.user!));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }


  Future<void> logout() async {
    await _service.logout();
    emit(Unauthenticated());
  }
}


//part of 'auth_cubit.dart';


abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}


class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class Authenticated extends AuthState {
  final User user;
  Authenticated(this.user);
  @override
  List<Object?> get props => [user];
}
class Unauthenticated extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
  @override
  List<Object?> get props => [message];
}