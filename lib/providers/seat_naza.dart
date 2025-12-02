import 'package:flutter/material.dart';
import 'package:sss_cinema/services/firestore_fahmi.dart';

class SeatProvider extends ChangeNotifier {
  List<String> selectedSeatsNaza = [];
  List<String> soldSeatsNaza = [];
  final FirestoreServiceFahmi _firestoreService = FirestoreServiceFahmi();
  String? _userId;
  String? _movieId;
  bool _selectedSeatsLoaded = false;

  bool get selectedSeatsLoaded => _selectedSeatsLoaded;

  /// kursi yang dipilih
  void toggleSeatNaza(String seat) {
    if (soldSeatsNaza.contains(seat))
      return; // kursi yg sudah sold, tidak bisa dipilih

    if (selectedSeatsNaza.contains(seat)) {
      selectedSeatsNaza.remove(seat);
    } else {
      selectedSeatsNaza.add(seat);
    }
    _saveSelectedSeats();
    notifyListeners();
  }

  void clearSelectedSeatsNaza() {
    selectedSeatsNaza.clear();
    _clearSelectedSeats();
    notifyListeners();
  }

  void listenSoldSeatsRealtime(String movieId) {
    _movieId = movieId;
    _firestoreService
        .getSoldSeatsFahmi(movieId)
        .listen((List<String> seats) {
          soldSeatsNaza = seats;
          selectedSeatsNaza.removeWhere((seat) => soldSeatsNaza.contains(seat));
          notifyListeners();
        });
  }

  Future<void> loadSelectedSeats(String userId, String movieId) async {
    _userId = userId;
    _movieId = movieId;
    selectedSeatsNaza = await _firestoreService.getSelectedSeatsFahmi(
      userId,
      movieId,
    );
    _selectedSeatsLoaded = true;
    notifyListeners();
  }

  Future<void> _saveSelectedSeats() async {
    if (_userId != null && _movieId != null) {
      await _firestoreService.saveSelectedSeatsFahmi(
        _userId!,
        _movieId!,
        selectedSeatsNaza,
      );
    }
  }

  Future<void> _clearSelectedSeats() async {
    if (_userId != null && _movieId != null) {
      await _firestoreService.clearSelectedSeatsFahmi(_userId!, _movieId!);
    }
  }

  bool isSelectedNaza(String seat) => selectedSeatsNaza.contains(seat);

  bool isSoldNaza(String seat) => soldSeatsNaza.contains(seat);
}
