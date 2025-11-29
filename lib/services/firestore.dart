import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie.dart';

class FirestoreServiceFahmi {
  final _db = FirebaseFirestore.instance;

  Future<List<MovieModelFahmi>> getMoviesFahmi() async {
    final query = await _db.collection('movies').get();
    return query.docs.map((d) => MovieModelFahmi.fromMap(d.data())).toList();
  }
}
