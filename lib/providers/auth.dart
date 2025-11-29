import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth.dart';

class AuthProviderFahmi with ChangeNotifier {
  final AuthServiceFahmi _authServiceFahmi = AuthServiceFahmi();

  User? currentUserFahmi;
  bool isLoadingFahmi = false;

  Future<void> registerUserFahmi(String email, String password) async {
    isLoadingFahmi = true;
    notifyListeners();

    currentUserFahmi = await _authServiceFahmi.registerUserFahmi(email, password);

    isLoadingFahmi = false;
    notifyListeners();
  }

  Future<void> loginUserFahmi(String email, String password) async {
    isLoadingFahmi = true;
    notifyListeners();

    currentUserFahmi = await _authServiceFahmi.loginUserFahmi(email, password);

    isLoadingFahmi = false;
    notifyListeners();
  }

  Future<void> logoutFahmi() async {
    await _authServiceFahmi.logoutFahmi();
    currentUserFahmi = null;
    notifyListeners();
  }
}
