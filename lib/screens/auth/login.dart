import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProviderFahmi>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 25),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Semua field harus diisi")),
                        );
                        return;
                      }

                      setState(() => isLoading = true);

                      try {
                        await auth.loginUserFahmi(email, password);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Berhasil")),
                        );

                        Navigator.pushReplacementNamed(context, '/home');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: $e")),
                        );
                      } finally {
                        setState(() => isLoading = false);
                      }
                    },
                    child: const Text("Login"),
                  ),
          ],
        ),
      ),
    );
  }
}
