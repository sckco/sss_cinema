import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sss_cinema/services/auth_fahmi.dart';
import 'package:sss_cinema/services/firestore_fahmi.dart';
import 'package:sss_cinema/models/user_fahmi.dart';
import 'package:sss_cinema/utils/constants_fahmi.dart';

class AuthProviderFahmi with ChangeNotifier {
  final AuthServiceFahmi _authServiceFahmi = AuthServiceFahmi();

  UserModelFahmi? currentUserFahmi;
  bool isLoadingFahmi = false;

  Future<void> registerUserFahmi(
    String name,
    String email,
    String password,
  ) async {
    isLoadingFahmi = true;
    notifyListeners();

    final firebaseUser = await _authServiceFahmi.registerUserFahmi(
      email,
      password,
    );

    if (firebaseUser != null) {
      final userModel = UserModelFahmi(
        uid: firebaseUser.uid,
        name: name,
        email: email,
        balance: 0,
      );

      await FirestoreServiceFahmi().addUserFahmi(userModel);

      currentUserFahmi = userModel;
    }

    isLoadingFahmi = false;
    notifyListeners();

    Future<void> logoutFahmi() async {
      await FirebaseAuth.instance.signOut();
      currentUserFahmi = null;
      notifyListeners();
    }
  }

  Future<void> loginUserFahmi(String email, String password) async {
    isLoadingFahmi = true;
    notifyListeners();

    final firebaseUser = await _authServiceFahmi.loginUserFahmi(
      email,
      password,
    );

    if (firebaseUser != null) {
      final data = await FirestoreServiceFahmi().getUserByUid(firebaseUser.uid);

      if (data != null) {
        currentUserFahmi = UserModelFahmi.fromMap(data);
      } else {
        currentUserFahmi = UserModelFahmi(
          uid: firebaseUser.uid,
          name: firebaseUser.displayName ?? "-",
          email: firebaseUser.email ?? "-",
        );
      }
    }

    isLoadingFahmi = false;
    notifyListeners();
  }

  Future<void> logoutFahmi() async {
    await _authServiceFahmi.logoutFahmi();
    currentUserFahmi = null;
    notifyListeners();
  }

  Stream<User?> streamAuthStatusFahmi() {
    return FirebaseAuth.instance.authStateChanges();
  }
}
