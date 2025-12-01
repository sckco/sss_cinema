import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceFahmi {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerUserFahmi(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<User?> loginUserFahmi(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<void> logoutFahmi() async {
    return _auth.signOut();
  }

  Stream<User?> getAuthStateChangesFahmi() => _auth.authStateChanges();
}
