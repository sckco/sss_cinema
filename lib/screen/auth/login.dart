import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth.dart';

class LoginFahmi extends StatefulWidget {
  const LoginFahmi({super.key});

  @override
  State<LoginFahmi> createState() => _LoginFahmiState();
}

class _LoginFahmiState extends State<LoginFahmi> {
  final emailControllerFahmi = TextEditingController();
  final passwordControllerFahmi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProviderFahmi>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login Fahmi")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailControllerFahmi,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordControllerFahmi,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            auth.isLoadingFahmi
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      await auth.loginUserFahmi(
                        emailControllerFahmi.text.trim(),
                        passwordControllerFahmi.text.trim(),
                      );
                    },
                    child: const Text("Login"),
                  ),
          ],
        ),
      ),
    );
  }
}
