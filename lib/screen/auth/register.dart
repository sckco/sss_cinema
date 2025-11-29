import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';

class RegisterFahmi extends StatefulWidget {
  const RegisterFahmi({super.key});

  @override
  State<RegisterFahmi> createState() => _RegisterFahmiState();
}

class _RegisterFahmiState extends State<RegisterFahmi> {
  final emailControllerFahmi = TextEditingController();
  final passwordControllerFahmi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProviderFahmi>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Register Fahmi")),
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
                      await auth.registerUserFahmi(
                        emailControllerFahmi.text.trim(),
                        passwordControllerFahmi.text.trim(),
                      );
                    },
                    child: const Text("Register"),
                  ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Sudah punya akun? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
