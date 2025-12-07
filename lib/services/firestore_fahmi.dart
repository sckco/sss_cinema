import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sss_cinema/models/movie_fahmi.dart';
import 'package:sss_cinema/models/booking_fahmi.dart';
import 'package:sss_cinema/models/user_fahmi.dart';
import 'package:sss_cinema/utils/constants_fahmi.dart';

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
          .where("user id", isEqualTo: userId)
          .orderBy("booking date", descending: true)
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

  Stream<List<String>> getSoldSeatsFahmi(String movieId) {
    return _db.collection('sold_seats_fahmi').doc(movieId).snapshots().map((
      DocumentSnapshot snapshot,
    ) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        return List<String>.from(data?['seats'] ?? []);
      }
      return [];
    });
  }

  Future<List<String>> getSoldSeatsListFahmi(String movieId) async {
    try {
      final snapshot = await _db
          .collection(FirestoreCollectionsFahmi.bookingsFahmi)
          .where('movieId', isEqualTo: movieId)
          .get();

      List<String> soldSeats = [];
      for (var doc in snapshot.docs) {
        BookingModelFahmi booking = BookingModelFahmi.fromMap(mapFromDoc(doc));
        soldSeats.addAll(booking.seats);
      }
      return soldSeats;
    } catch (e) {
      print("Error getSoldSeatsListFahmi: $e");
      return [];
    }
  }

  Future<String?> checkoutBookingTransactionFahmi(
    BookingModelFahmi booking,
  ) async {
    try {
      return await _db.runTransaction<String?>((transaction) async {
        final soldSeatsDocRef = _db
            .collection('sold_seats_fahmi')
            .doc(booking.movieId);
        final soldSeatsDoc = await transaction.get(soldSeatsDocRef);

        List<String> soldSeats = [];
        if (soldSeatsDoc.exists) {
          soldSeats = List<String>.from(soldSeatsDoc.data()?['seats'] ?? []);
        }

        final unavailableSeats = booking.seats
            .where((seat) => soldSeats.contains(seat))
            .toList();
        if (unavailableSeats.isNotEmpty) {
          return null;
        }

        soldSeats.addAll(booking.seats);
        transaction.set(soldSeatsDocRef, {'seats': soldSeats});

        final bookingDocRef = _db
            .collection(FirestoreCollectionsFahmi.bookingsFahmi)
            .doc();
        transaction.set(bookingDocRef, booking.toMap());
        return bookingDocRef.id;
      });
    } catch (e) {
      print("Error checkoutBookingTransactionFahmi: $e");
      return null;
    }
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

  Future<void> saveSelectedSeatsFahmi(
    String userId,
    String movieId,
    List<String> seats,
  ) async {
    try {
      await _db
          .collection('selected_seats_fahmi')
          .doc('${userId}_$movieId')
          .set({'seats': seats});
    } catch (e) {
      print("Error saveSelectedSeatsFahmi: $e");
    }
  }

  Future<List<String>> getSelectedSeatsFahmi(
    String userId,
    String movieId,
  ) async {
    try {
      final doc = await _db
          .collection('selected_seats_fahmi')
          .doc('${userId}_$movieId')
          .get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>?;
        return List<String>.from(data?['seats'] ?? []);
      }
      return [];
    } catch (e) {
      print("Error getSelectedSeatsFahmi: $e");
      return [];
    }
  }

  Future<void> clearSelectedSeatsFahmi(String userId, String movieId) async {
    try {
      await _db
          .collection('selected_seats_fahmi')
          .doc('${userId}_$movieId')
          .delete();
    } catch (e) {
      print("Error clearSelectedSeatsFahmi: $e");
    }
  }
}
