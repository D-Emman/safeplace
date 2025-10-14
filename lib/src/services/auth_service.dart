import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _secure = const FlutterSecureStorage();


  Future<UserCredential> registerWithEmail({required String email, required String password}) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
// store token if needed
    final token = await cred.user?.getIdToken();
    if (token != null) await _secure.write(key: 'jwt', value: token);
    return cred;
  }


  Future<UserCredential> login({required String email, required String password}) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final token = await cred.user?.getIdToken();
    if (token != null) await _secure.write(key: 'jwt', value: token);
    return cred;
  }


  Future<void> logout() async {
    await _auth.signOut();
    await _secure.delete(key: 'jwt');
  }


  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }


  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.delete();
      await _secure.delete(key: 'jwt');
    }
  }
}

//pause