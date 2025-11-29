import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sss_cinema/providers/movie.dart';
import 'package:sss_cinema/widgets/movie.dart';
import 'package:sss_cinema/models/movie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerDaniel = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
        "SSS Cinema",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          letterSpacing: 1.2,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    ),
      body: RefreshIndicator(
        onRefresh: () => providerDaniel.loadMoviesDaniel(),
        child: providerDaniel.loadingDaniel
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: providerDaniel.movieListDaniel.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) {
                  MovieModel movieDaniel = providerDaniel.movieListDaniel[index];
                  return MovieItemWidget(movieDaniel: movieDaniel);
                },
              ),
      ),
    );
  }
}
