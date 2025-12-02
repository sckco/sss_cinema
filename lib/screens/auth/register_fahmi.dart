import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sss_cinema/providers/auth_fahmi.dart';
import 'package:sss_cinema/screens/auth/login_fahmi.dart';
import 'package:sss_cinema/utils/validators_fahmi.dart';
import 'package:sss_cinema/utils/constants_fahmi.dart';

class RegisterFahmi extends StatefulWidget {
  const RegisterFahmi({super.key});

  @override
  State<RegisterFahmi> createState() => _RegisterFahmiState();
}

class _RegisterFahmiState extends State<RegisterFahmi> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool nameError = false;
  bool emailError = false;
  bool passwordError = false;
  String nameErrorMessage = '';
  String emailErrorMessage = '';
  String passwordErrorMessage = '';

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _validateFields() {
    setState(() {
      nameError = nameController.text.trim().isEmpty;
      nameErrorMessage = nameError ? 'Nama harus diisi' : '';

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
              // Banner di bawah navbar
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Image.asset('assets/banner_sss.png', fit: BoxFit.cover),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: const OutlineInputBorder(),
                  errorText: nameError ? nameErrorMessage : null,
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: const OutlineInputBorder(),
                  errorText: emailError ? emailErrorMessage : null,
                ),
                keyboardType: TextInputType.emailAddress,
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
                          if (nameError || emailError || passwordError) return;

                          setState(() => isLoading = true);

                          try {
                            await authProvider.registerUserFahmi(
                              nameController.text.trim(),
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );

                            if (authProvider.currentUserFahmi != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Register sukses!'),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          } finally {
                            setState(() => isLoading = false);
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('Sudah punya akun? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
