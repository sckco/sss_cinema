import 'package:flutter/material.dart';
import 'package:sss_cinema/models/movie.dart';

class DetailScreen extends StatelessWidget {
  final MovieModelFahmi movieDaniel;

  const DetailScreen({super.key, required this.movieDaniel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          movieDaniel.title,
          style: const TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Color(0xFF1A0000),
              Color(0xFF2B0000),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          children: [
            // SCROLL AREA
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: movieDaniel.movieId,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          movieDaniel.posterUrl,
                          fit: BoxFit.cover,
                          height: 380,
                          width: double.infinity,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      movieDaniel.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text("⭐ Rating: ${movieDaniel.rating}",
                        style: const TextStyle(color: Colors.white70)),
                    Text("⏱ Duration: ${movieDaniel.duration} mins",
                        style: const TextStyle(color: Colors.white70)),
                    Text("💵 Price: Rp ${movieDaniel.basePrice}",
                        style: const TextStyle(color: Colors.white70)),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // BUTTON di paling bawah
            Padding(
              padding: const EdgeInsets.all(18),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: const Size(double.infinity, 55),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/seat',
                    arguments: movieDaniel,
                  );
                },
                child: const Text(
                  "Pilih Kursi",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
