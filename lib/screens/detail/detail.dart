import 'package:flutter/material.dart';
import 'package:sss_cinema/models/movie.dart';

class DetailScreen extends StatelessWidget {
  final MovieModelFahmi movieDaniel;

  const DetailScreen({super.key, required this.movieDaniel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movieDaniel.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: movieDaniel.movieId,
              child: Image.network(movieDaniel.posterUrl),
            ),
            const SizedBox(height: 16),
            Text(
              movieDaniel.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Rating: ${movieDaniel.rating}'),
            const SizedBox(height: 8),
            Text('Duration: ${movieDaniel.duration} minutes'),
            const SizedBox(height: 8),
            Text('Price: Rp ${movieDaniel.basePrice}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/seat', arguments: movieDaniel);
              },
              child: const Text('Pilih Kursi'),
            ),
          ],
        ),
      ),
    );
  }
}
