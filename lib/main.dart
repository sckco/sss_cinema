import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sss_cinema/screens/profile/profile.dart';

import 'firebase_options.dart';
import 'providers/auth.dart';
import 'providers/movie.dart';
import 'providers/seat.dart';
import 'providers/booking.dart';

import 'screens/auth/login.dart';
import 'screens/home/home.dart';
import 'screens/detail/detail.dart';
import 'screens/seat/seat.dart';
import 'models/movie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SssCinema());
}

class SssCinema extends StatelessWidget {
  const SssCinema({super.key});

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
            return DetailScreen(movieDaniel: movie);
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
