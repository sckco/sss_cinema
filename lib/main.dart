import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/home/home.dart';
import 'package:sss_cinema/providers/auth_provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SssCinemaApp());
}

class SssCinemaApp extends StatelessWidget {
  const SssCinemaApp({super.key});

   @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProviderFahmi()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "SSS Cinema",
        theme: ThemeData(primarySwatch: Colors.blue),

        // HALAMAN AWAL
        home: const LoginScreen(),

        // ROUTE NAVIGASI
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterFahmi(),
          '/home': (context) => const HomeScreen(),

        },
      ),
    );
  }
}
