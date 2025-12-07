import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sss_cinema/screens/profile/profile_all.dart';

import 'firebase_options.dart';
import 'providers/auth_fahmi.dart';
import 'providers/movie_daniel.dart';
import 'providers/seat_naza.dart';
import 'providers/booking_rendra.dart';

import 'screens/auth/login_fahmi.dart';
import 'screens/home/home_daniel.dart';
import 'screens/detail/detail_rendra.dart';
import 'screens/seat/seat_naza.dart';
import 'models/movie_fahmi.dart';

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
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => SeatProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "SSS Cinema",

        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          colorScheme: const ColorScheme.dark(
            primary: Colors.redAccent,
            secondary: Colors.red,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),

        routes: {
          '/login': (context) => const LoginScreen(), // wajib ada
          '/profile': (context) => const ProfileScreenFahmi(),
          '/home': (context) => const HomeScreen(),

          '/detail': (context) {
            final movie =
                ModalRoute.of(context)!.settings.arguments as MovieModelFahmi;
            return DetailScreenRendra(movieDaniel: movie);
          },

          '/seat': (context) {
            final movie =
                ModalRoute.of(context)!.settings.arguments as MovieModelFahmi;
            return SeatScreen(movie: movie);
          },
        },

        home: const RootScreen(),
      ),
    );
  }
}

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProviderFahmi>(context, listen: false);

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data != null) {
          authProv.loadCurrentUserFahmi();
          return const HomeScreen();
        }

        return const LoginScreen();
      },
    );
  }
}

