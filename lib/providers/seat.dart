import 'package:flutter/material.dart';
import 'package:sss_cinema/services/firestore.dart';

class SeatProvider extends ChangeNotifier {
  List<String> selectedSeatsNaza = [];
  List<String> soldSeatsNaza = [];
  final FirestoreServiceFahmi _firestoreService = FirestoreServiceFahmi();

  void toggleSeatNaza(String seat) {
    if (soldSeatsNaza.contains(seat)) return;

    if (selectedSeatsNaza.contains(seat)) {
      selectedSeatsNaza.remove(seat);
    } else {
      selectedSeatsNaza.add(seat);
    }
    notifyListeners();
  }

  void clearSelectedSeatsNaza() {
    selectedSeatsNaza.clear();
    notifyListeners();
  }

  Future<void> loadSoldSeatsNaza(String movieId) async {
    // Ambil kursi yang sudah dipesan dari Firestore
    soldSeatsNaza = await _firestoreService.getSoldSeatsFahmi(movieId);
    notifyListeners();
  }

  bool isSelectedNaza(String seat) => selectedSeatsNaza.contains(seat);
  bool isSoldNaza(String seat) => soldSeatsNaza.contains(seat);
}
