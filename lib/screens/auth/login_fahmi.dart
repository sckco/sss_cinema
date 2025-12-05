import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sss_cinema/providers/auth_fahmi.dart';
import 'package:sss_cinema/screens/auth/register_fahmi.dart';
import 'package:sss_cinema/utils/validators_fahmi.dart';
import 'package:sss_cinema/utils/constants_fahmi.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool emailError = false;
  bool passwordError = false;
  String emailErrorMessage = '';
  String passwordErrorMessage = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _validateFields() {
    setState(() {
      emailError = !isValidEmailFahmi(emailController.text.trim());
      emailErrorMessage = emailError
          ? ErrorMessagesFahmi.invalidEmailFahmi
          : '';

      passwordError = !isValidPasswordFahmi(passwordController.text.trim());
      passwordErrorMessage = passwordError
          ? ErrorMessagesFahmi.weakPasswordFahmi
          : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderFahmi>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SSS Cinema",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 2,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Image.asset('assets/banner_sss.png', fit: BoxFit.cover),
              ),

              const SizedBox(height: 30),

              // login
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: const OutlineInputBorder(),
                  errorText: emailError ? emailErrorMessage : null,
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  errorText: passwordError ? passwordErrorMessage : null,
                ),
              ),
              const SizedBox(height: 20),

              isLoading || authProvider.isLoadingFahmi
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          _validateFields();
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          if (email.isEmpty ||
                              password.isEmpty ||
                              emailError ||
                              passwordError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Email dan password harus diisi!',
                                ),
                              ),
                            );
                            return;
                          }

                          setState(() => isLoading = true);

                          try {
                            await authProvider.loginUserFahmi(email, password);

                            if (authProvider.currentUserFahmi != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Login sukses!')),
                              );
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          } finally {
                            setState(() => isLoading = false);
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterFahmi(),
                    ),
                  );
                },
                child: const Text('Belum punya akun? Daftar disini'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
