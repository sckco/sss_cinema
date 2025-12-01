import 'package:flutter/material.dart';
import 'package:sss_cinema/services/firestore.dart';

class SeatProvider extends ChangeNotifier {
  List<String> selectedSeatsNaza = [];
  List<String> soldSeatsNaza = [];
  final FirestoreServiceFahmi _firestoreService = FirestoreServiceFahmi();
  String? _userId;
  String? _movieId;
  bool _selectedSeatsLoaded = false;

  bool get selectedSeatsLoaded => _selectedSeatsLoaded;

  /// Toggle kursi yang dipilih
  void toggleSeatNaza(String seat) {
    if (soldSeatsNaza.contains(seat))
      return; // Kursi sudah sold, tidak bisa dipilih

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
        .getSoldSeatsFahmi(movieId) // stream dari collection bookings
        .listen((List<String> seats) {
          soldSeatsNaza = seats;
          // hapus dari selectedSeats agar tidak bisa dipilih
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

  /// Cek apakah kursi dipilih
  bool isSelectedNaza(String seat) => selectedSeatsNaza.contains(seat);

  /// Cek apakah kursi sudah sold
  bool isSoldNaza(String seat) => soldSeatsNaza.contains(seat);
}
