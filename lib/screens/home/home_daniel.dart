import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sss_cinema/providers/movie_daniel.dart';
import 'package:sss_cinema/screens/profile/profile_all.dart';
import 'package:sss_cinema/widgets/movie_daniel.dart';
import 'package:sss_cinema/models/movie_fahmi.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerDaniel = Provider.of<MovieProvider>(context);

    if (providerDaniel.movieListDaniel.isEmpty && !providerDaniel.loadingDaniel) {
      providerDaniel.loadMoviesDaniel();
    }

    return Scaffold(
      backgroundColor: const Color(0xFF000000),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text(
          "SSS CINEMA",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 24,
            letterSpacing: 1.5,
            color: Colors.redAccent,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.redAccent, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreenFahmi()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF000000),
              Color(0xFF1A0000),
              Color(0xFF2B0000),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: RefreshIndicator(
          onRefresh: () => providerDaniel.loadMoviesDaniel(),
          color: Colors.redAccent,
          backgroundColor: Colors.black,

          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            itemCount: providerDaniel.movieListDaniel.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.62,
            ),

            itemBuilder: (context, index) {
              final movieDaniel = providerDaniel.movieListDaniel[index];

              return Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 99, 6, 6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: MovieItemWidget(movieDaniel: movieDaniel),
              );
            },
          ),
        ),
      ),
    );
  }
}
