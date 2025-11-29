import 'package:flutter/material.dart';
import 'package:sss_cinema/models/movie.dart';
import 'package:sss_cinema/screens/detail/detail.dart';

class MovieItemWidget extends StatelessWidget {
  final MovieModel movieDaniel;

  const MovieItemWidget({super.key, required this.movieDaniel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(movieDaniel: movieDaniel),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Hero(
              tag: movieDaniel.movieId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  movieDaniel.posterUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movieDaniel.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("${movieDaniel.rating} ⭐"),
        ],
      ),
    );
  }
}
