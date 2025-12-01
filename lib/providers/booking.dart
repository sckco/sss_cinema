import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sss_cinema/models/booking.dart';
import 'package:sss_cinema/services/firestore.dart';

class BookingProvider extends ChangeNotifier {
  final FirestoreServiceFahmi _firestoreService = FirestoreServiceFahmi();

  int calculateTotal({
    required String movieTitle,
    required int basePrice,
    required List<String> seats,
  }) {
    int total = 0;
    final longTitle = movieTitle.length > 10;
    for (final seat in seats) {
      final numPart = seat.replaceAll(RegExp(r'[^0-9]'), '');
      final seatNum = int.tryParse(numPart) ?? 0;
      int price = basePrice;
      if (seatNum % 2 == 0) price -= (price * 0.10).round();
      if (longTitle) price += 2500;
      total += price;
    }
    return total;
  }

  Future<String> checkoutBooking({
    required String userId,
    required String movieId,
    required String movieTitle,
    required List<String> seats,
    required int basePrice,
  }) async {
    final total = calculateTotal(movieTitle: movieTitle, basePrice: basePrice, seats: seats);
    final id = const Uuid().v4();
    final booking = BookingModelFahmi(
      bookingId: id,
      userId: userId,
      movieId: movieId,
      movieTitle: movieTitle,
      seats: seats,
      totalPrice: total,
      bookingDate: Timestamp.now(),
    );

    // Simpan ke Firestore
    await _firestoreService.addBookingReturnIdFahmi(booking);
    return id;
  }
}
