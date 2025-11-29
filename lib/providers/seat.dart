import 'package:flutter/material.dart';
import 'package:sss_cinema/services/firestore.dart';

class SeatProvider extends ChangeNotifier {
  List<String> selectedSeatsNaza = [];
  List<String> soldSeatsNaza = [];
  final FirestoreService _firestoreServiceFahmi = FirestoreService();

  void toggleSeatNaza(String seat) {
    if (soldSeatsNaza.contains(seat)) return;
    if (selectedSeatsNaza.contains(seat)) selectedSeatsNaza.remove(seat);
    else selectedSeatsNaza.add(seat);
    notifyListeners();
  }

}
