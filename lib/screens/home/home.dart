import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sss_cinema/providers/movie.dart';
import 'package:sss_cinema/widgets/movie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "SSS",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              TextSpan(
                text: " Cinema",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: () => provider.loadMoviesDaniel(),
        backgroundColor: Colors.redAccent,
        color: const Color.fromARGB(255, 0, 0, 0),
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          itemCount: provider.movieListDaniel.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 16,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            final movie = provider.movieListDaniel[index];
            return MovieItemWidget(movieDaniel: movie);
          },
        ),
      ),
    );
  }
}
