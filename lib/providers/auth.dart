import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sss_cinema/services/auth.dart';
import 'package:sss_cinema/services/firestore.dart';
import 'package:sss_cinema/models/user.dart';
import 'package:sss_cinema/utils/constants.dart';

class AuthProviderFahmi with ChangeNotifier {
  final AuthServiceFahmi _authServiceFahmi = AuthServiceFahmi();

  User? currentUserFahmi;
  bool isLoadingFahmi = false;

  Future<void> registerUserFahmi(
    String name,
    String email,
    String password,
  ) async {
    isLoadingFahmi = true;
    notifyListeners();

    currentUserFahmi = await _authServiceFahmi.registerUserFahmi(
      email,
      password,
    );

    // Save user data to Firestore
    if (currentUserFahmi != null) {
      final userModel = UserModelFahmi(
        uid: currentUserFahmi!.uid,
        name: name,
        email: email,
      );
      await FirestoreServiceFahmi().addUserFahmi(userModel);
    }

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

  Stream<User?> streamAuthStatusFahmi() =>
      _authServiceFahmi.getAuthStateChangesFahmi();
}
