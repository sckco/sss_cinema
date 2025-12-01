import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie.dart';
import '../models/booking.dart';

class FirestoreServiceFahmi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Helper null-safe
  Map<String, dynamic> mapFromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    if (data != null && data is Map<String, dynamic>) {
      return data;
    }
    return {};
  }

  // Ambil semua film
  Future<List<MovieModelFahmi>> getMoviesFahmi() async {
    try {
      final snapshot = await _db.collection('movies').get();
      return snapshot.docs
          .map((doc) => MovieModelFahmi.fromMap(mapFromDoc(doc)))
          .toList();
    } catch (e) {
      print("Error getMoviesFahmi: $e");
      return [];
    }
  }

  // Ambil kursi yang sudah terpesan
  Future<List<String>> getSoldSeatsFahmi(String movieId) async {
    try {
      final snapshot = await _db
          .collection('bookings')
          .where('movieId', isEqualTo: movieId)
          .get();

      List<String> soldSeats = [];
      for (var doc in snapshot.docs) {
        final booking = BookingModelFahmi.fromMap(mapFromDoc(doc));
        soldSeats.addAll(booking.seats);
      }
      return soldSeats;
    } catch (e) {
      print("Error getSoldSeatsFahmi: $e");
      return [];
    }
  }

  // Tambah booking
  Future<void> addBookingFahmi(BookingModelFahmi booking) async {
    try {
      await _db.collection('bookings').add(booking.toMap());
    } catch (e) {
      print("Error addBookingFahmi: $e");
    }
  }
}
