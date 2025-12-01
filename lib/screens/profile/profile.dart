import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:sss_cinema/providers/auth.dart';
import 'package:sss_cinema/models/user.dart';

class ProfileScreenFahmi extends StatelessWidget {
  const ProfileScreenFahmi({super.key});

  String _extractName(dynamic user) {
    if (user == null) return '-';
    if (user is UserModelFahmi) return user.name;
    if (user is User) return user.displayName ?? user.email ?? '-';
    if (user is Map) return (user['name'] ?? user['displayName'] ?? user['email'] ?? '-').toString();
    try {
      final v = user.name ?? user.displayName ?? user['name'] ?? user['displayName'];
      return v?.toString() ?? '-';
    } catch (_) {
      return '-';
    }
  }

  String _extractEmail(dynamic user) {
    if (user == null) return '-';
    if (user is UserModelFahmi) return user.email;
    if (user is User) return user.email ?? '-';
    if (user is Map) return (user['email'] ?? '-').toString();
    try {
      final v = user.email ?? user['email'];
      return v?.toString() ?? '-';
    } catch (_) {
      return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderFahmi>(context);
    final dynamic user = authProvider.currentUserFahmi;

    final name = _extractName(user);
    final email = _extractEmail(user);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.redAccent,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Nama: $name",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              "Email: $email",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  await authProvider.logoutFahmi();
                  Navigator.pushReplacementNamed(context, "/login");
                },
                
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
