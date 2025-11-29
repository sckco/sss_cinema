import 'package:sss_cinema/models/movie.dart';
import 'package:sss_cinema/models/booking.dart';
import 'package:sss_cinema/utils/helper.dart';
import 'package:sss_cinema/utils/constants.dart';



class FirestoreServiceFahmi {
  final FirebaseFirestore _dbFahmi = FirebaseFirestore.instance;

  // Helper function untuk aman null-safety
  Map<String, dynamic> mapFromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    if (data != null && data is Map<String, dynamic>) {
      return data;
    }
    return {};
  }

  Future<List<MovieModelFahmi>> getMoviesFahmi() async {
    try {
      QuerySnapshot snapshot = await _dbFahmi
          .collection(FirestoreCollectionsFahmi.moviesFahmi)
          .get();

      return snapshot.docs
          .map((doc) => MovieModelFahmi.fromMap(mapFromDoc(doc), doc.id))
          .toList();
    } catch (e) {
      print("Error getMoviesFahmi: $e");
      return [];
    }
  }

  Future<void> addBookingFahmi(BookingModelFahmi booking) async {
    try {
      await _dbFahmi
          .collection(FirestoreCollectionsFahmi.bookingsFahmi)
          .add(booking.toMap());
    } catch (e) {
      print("Error addBookingFahmi: $e");
    }
  }

  Future<void> updateBookingFahmi(String id, BookingModelFahmi booking) async {
    try {
      await _dbFahmi
          .collection(FirestoreCollectionsFahmi.bookingsFahmi)
          .doc(id)
          .update(booking.toMap());
    } catch (e) {
      print("Error updateBookingFahmi: $e");
    }
  }

  Future<void> deleteBookingFahmi(String id) async {
    try {
      await _dbFahmi
          .collection(FirestoreCollectionsFahmi.bookingsFahmi)
          .doc(id)
          .delete();
    } catch (e) {
      print("Error deleteBookingFahmi: $e");
    }
  }

  Future<List<BookingModelFahmi>> getBookingsByUserFahmi(String userId) async {
    try {
      QuerySnapshot snapshot = await _dbFahmi
          .collection(FirestoreCollectionsFahmi.bookingsFahmi)
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs
          .map((doc) => BookingModelFahmi.fromMap(mapFromDoc(doc), doc.id))
          .toList();
    } catch (e) {
      print("Error getBookingsByUserFahmi: $e");
      return [];
    }
  }
}
