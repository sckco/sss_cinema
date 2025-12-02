import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelperFahmi {
  static Map<String, dynamic> mapFromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    if (data != null && data is Map<String, dynamic>) {
      return data;
    }
    return {};
  }
}
