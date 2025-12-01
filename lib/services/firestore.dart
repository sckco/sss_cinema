import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sss_cinema/models/movie.dart';
import 'package:sss_cinema/models/booking.dart';
import 'package:sss_cinema/models/user.dart';
import 'package:sss_cinema/utils/helper.dart';
import 'package:sss_cinema/utils/constants.dart';

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

  Future<void> addUserFahmi(UserModelFahmi user) async {
    try {
      await _dbFahmi
          .collection(FirestoreCollectionsFahmi.usersFahmi)
          .doc(user.uid)
          .set(user.toMap());
    } catch (e) {
      print("Error addUserFahmi: $e");
    }
  }
}
