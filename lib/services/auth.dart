import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceFahmi {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register user
  Future<User?> registerUserFahmi(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      rethrow;
    }
  }

  // Login user
  Future<User?> loginUserFahmi(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      rethrow;
    }
  }

  // Logout
  Future<void> logoutFahmi() async {
    await _auth.signOut();
  }

  // Current user
  User? get currentUser => _auth.currentUser;

  // Stream auth state
  Stream<User?> getAuthStateChangesFahmi() {
    return _auth.authStateChanges();
  }
}
