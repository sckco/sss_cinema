import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModelFahmi {
  final String bookingId;
  final String movieId;
  final String userId;
  final String movieTitle;
  final List<String> seats;
  final int totalPrice;
  final Timestamp bookingDate;

  BookingModelFahmi({
    required this.bookingId,
    required this.movieId,
    required this.userId,
    required this.movieTitle,
    required this.seats,
    required this.totalPrice,
    required this.bookingDate,
  });

  factory BookingModelFahmi.fromMap(Map<String, dynamic> m) {
    return BookingModelFahmi(
      bookingId: m['booking id'],
      movieId: m['movie id'],
      userId: m['user id'],
      movieTitle: m['movie title'],
      seats: List<String>.from(m['seats']),
      totalPrice: m['total price'],
      bookingDate: m['booking date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'booking id': bookingId,
      'movie id': movieId,
      'user id': userId,
      'movie title': movieTitle,
      'seats': seats,
      'total price': totalPrice,
      'booking date': bookingDate,
    };
  }
}
