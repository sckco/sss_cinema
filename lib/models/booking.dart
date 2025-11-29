class BookingModelFahmi {
  final String bookingId;
  final String movieId;
  final String userId;
  final List<String> seats;
  final int totalPrice;

  BookingModelFahmi({
    required this.bookingId,
    required this.movieId,
    required this.userId,
    required this.seats,
    required this.totalPrice,
  });

  factory BookingModelFahmi.fromMap(Map<String, dynamic> m) {
    return BookingModelFahmi(
      bookingId: m['booking id'],
      movieId: m['movie id'],
      userId: m['user id'],
      seats: List<String>.from(m['seats']),
      totalPrice: m['total price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'booking id': bookingId,
      'movie id': movieId,
      'user id': userId,
      'seats': seats,
      'total price': totalPrice,
    };
  }
}
