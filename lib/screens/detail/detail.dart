import 'package:flutter/material.dart';
import 'package:sss_cinema/models/movie.dart';
import 'package:sss_cinema/screens/seat.dart';

class DetailScreen extends StatelessWidget {
  final MovieModelFahmi movieDaniel;
  const DetailScreen({super.key, required this.movieDaniel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieDaniel.title, style: const TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(movieDaniel.posterUrl, height: 300, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movieDaniel.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  Text('Rating: ${movieDaniel.rating}', style: const TextStyle(color: Colors.white70)),
                  Text('Duration: ${movieDaniel.duration} min', style: const TextStyle(color: Colors.white70)),
                  Text('Price: Rp ${movieDaniel.basePrice}', style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SeatScreen(movie: movieDaniel),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red[800]),
                      child: const Text('PILIH KURSI', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}