import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';
import 'providers/auth.dart';
import 'providers/movie.dart';
import 'providers/seat.dart';
import 'providers/booking.dart';

import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/home/home.dart';
import 'package:sss_cinema/providers/auth.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SssCinema());
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
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const RootScreen(),
      ),
    );
  }
}

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProviderFahmi>(context, listen: false);

    return StreamBuilder<User?>(
      stream: auth.streamAuthStatusFahmi(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text("Terjadi kesalahan")));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data != null) {
          return const HomeScreen();
        }

        return const LoginScreen();
      },
    );
  }
}
