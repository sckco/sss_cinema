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
      movieId: m['movie id'],
      title: m['title'],
      posterUrl: m['poster url'],
      basePrice: m['base price'],
      rating: (m['rating'] as num).toDouble(),
      duration: m['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'movie id': movieId,
      'title': title,
      'poster url': posterUrl,
      'base price': basePrice,
      'rating': rating,
      'duration': duration,
    };
  }
}
