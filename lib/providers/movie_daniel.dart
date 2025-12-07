import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sss_cinema/models/movie_fahmi.dart';
import 'package:sss_cinema/services/seeder_fahmi.dart';
import 'package:sss_cinema/utils/constants_fahmi.dart';

class MovieProvider extends ChangeNotifier {
  List<MovieModelFahmi> movieListDaniel = [];
  bool loadingDaniel = false;

  Future loadMoviesDaniel() async {
    loadingDaniel = true;
    notifyListeners();

    final snapshot = await FirebaseFirestore.instance
        .collection('movies')
        .get();
    movieListDaniel = snapshot.docs
        .map((doc) => MovieModelFahmi.fromMap(doc.data()))
        .toList();

    loadingDaniel = false;
    notifyListeners();
  }
}
