class MovieModelFahmi {
  final String movieId;
  final String title;
  final String posterUrl;
  final int basePrice;
  final double rating;
  final int duration;

  MovieModelFahmi({
    required this.movieId,
    required this.title,
    required this.posterUrl,
    required this.basePrice,
    required this.rating,
    required this.duration,
  });

  factory MovieModelFahmi.fromMap(Map<String, dynamic> m) {
    return MovieModelFahmi(
      movieId: m['movieId'],
      title: m['title'],
      posterUrl: m['posterUrl'],
      basePrice: m['basePrice'],
      rating: (m['rating'] as num).toDouble(),
      duration: m['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'movieId': movieId,
      'title': title,
      'posterUrl': posterUrl,
      'basePrice': basePrice,
      'rating': rating,
      'duration': duration,
    };
  }
}
