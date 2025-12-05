import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/booking.dart';
class FirestoreServiceFahmi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Map<String, dynamic> mapFromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    if (data != null && data is Map<String, dynamic>) return data;
    return {};
  }

  Future<List<String>> getSoldSeatsFahmi(String movieId) async {
    try {
      final snapshot = await _db
          .collection('bookings')
          .where('movieId', isEqualTo: movieId)
          .get();

      List<String> soldSeats = [];
      for (var doc in snapshot.docs) {
        final map = mapFromDoc(doc);
        final bookingSeats = map['seats'];
        if (bookingSeats != null && bookingSeats is List) {
          soldSeats.addAll(List<String>.from(bookingSeats));
        }
      }

      return soldSeats;
    } catch (e) {
      print("Error getSoldSeatsFahmi: $e");
      return [];
    }
  }
}
  
