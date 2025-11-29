import 'package:flutter/material.dart';
import 'package:sss_cinema/models/movie.dart';
import 'package:sss_cinema/screen/seat/seat.dart';

class DetailScreen extends StatelessWidget {
  final MovieModel movie;
  const DetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    final longTitleRendra = movie.title.length > 10;
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SeatScreen(movie: movie)),
        ),
        label: Text('Book Ticket'),
        icon: Icon(Icons.event_seat),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Hero(
              tag: 'poster-${movie.movieId}',
              child: Image.network(
                movie.posterUrl,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12),
            Text(
              movie.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.star, size: 18),
                SizedBox(width: 6),
                Text('${movie.rating}'),
                SizedBox(width: 16),
                Icon(Icons.timer, size: 18),
                SizedBox(width: 6),
                Text('${movie.duration} menit'),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Harga dasar: Rp ${movie.basePrice}',
              style: TextStyle(fontSize: 16),
            ),
            if (longTitleRendra) SizedBox(height: 8),
            if (longTitleRendra)
              Text(
                'Pajak judul panjang berlaku (+Rp 2.500 per kursi)',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
