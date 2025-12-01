import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';   

class AuthProviderFahmi with ChangeNotifier {
 final AuthServiceFahmi _authService = AuthServiceFahmi();


  User? _user;
  User? get user => _user;

  Future<UserCredential> loginUserFahmi(String email, String password) async {
  return await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}


Fclass AuthServiceFahmi {
  Future<UserCredential> registerUserFahmi(String email, String password) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logoutUserFahmi() async {
    await FirebaseAuth.instance.signOut();
  }
}


  Future<void> logoutUserFahmi() async {
    await _authService.logoutUserFahmi();
    _user = null;
    notifyListeners();
  }
}
