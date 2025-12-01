import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sss_cinema/models/movie.dart';
import 'package:sss_cinema/models/booking.dart';
import 'package:sss_cinema/models/user.dart';
import 'package:sss_cinema/utils/constants.dart';

class FirestoreServiceFahmi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Map<String, dynamic> mapFromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    if (data != null && data is Map<String, dynamic>) return data;
    return {};
  }

  Future<List<MovieModelFahmi>> getMoviesFahmi() async {
    try {
      final snapshot = await _db
          .collection(FirestoreCollectionsFahmi.moviesFahmi)
          .get();

      return snapshot.docs
          .map((doc) => MovieModelFahmi.fromMap(mapFromDoc(doc)))
          .toList();
    } catch (e) {
      print("Error getMoviesFahmi: $e");
      return [];
    }
  }

  Future<String> addBookingReturnIdFahmi(BookingModelFahmi booking) async {
    try {
      final docRef = await _db
          .collection(FirestoreCollectionsFahmi.bookingsFahmi)
          .add(booking.toMap());

      return docRef.id;
    } catch (e) {
      print("Error addBookingReturnIdFahmi: $e");
      return "";
    }
  }

  Future<List<BookingModelFahmi>> getBookingsByUserFahmi(String userId) async {
    try {
      final snapshot = await _db
          .collection(FirestoreCollectionsFahmi.bookingsFahmi)
          .where("userId", isEqualTo: userId)
          .get();

      return snapshot.docs
          .map((doc) => BookingModelFahmi.fromMap(mapFromDoc(doc)))
          .toList();
    } catch (e) {
      print("Error getBookingsByUserFahmi: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>?> getUserByUid(String uid) async {
    try {
      final doc = await _db
          .collection(FirestoreCollectionsFahmi.usersFahmi)
          .doc(uid)
          .get();

      if (!doc.exists) return null;
      return mapFromDoc(doc);
    } catch (e) {
      print("Error getUserByUid: $e");
      return null;
    }
  }

Future<List<String>> getSoldSeatsFahmi(String movieId) async {
  QuerySnapshot snapshot = await _db
      .collection(FirestoreCollectionsFahmi.bookingsFahmi)
      .where('movieId', isEqualTo: movieId)
      .get();

  List<String> soldSeats = [];
  for (var doc in snapshot.docs) {
    BookingModelFahmi booking = BookingModelFahmi.fromMap(mapFromDoc(doc));
    soldSeats.addAll(booking.seats);
  }
  return soldSeats;
}

  Future<void> addUserFahmi(UserModelFahmi user) async {
    try {
      await _db
          .collection(FirestoreCollectionsFahmi.usersFahmi)
          .doc(user.uid)
          .set(user.toMap());
    } catch (e) {
      print("Error addUserFahmi: $e");
    }
  }
}
