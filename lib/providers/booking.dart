import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sss_cinema/models/booking.dart';
import 'package:sss_cinema/services/firestore.dart';

class BookingProvider extends ChangeNotifier {
  final FirestoreService _firestoreServiceFahmi = FirestoreService();

  int calculateTotalNaza({
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
      if (seatNum % 2 == 0) {
        final discount = (price * 0.10).round();
        price = price - discount;
      }
      if (longTitle) price += 2500;
      total += price;
    }
    return total;
  }