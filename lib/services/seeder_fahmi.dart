import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sss_cinema/models/movie_fahmi.dart';
import 'package:sss_cinema/utils/constants_fahmi.dart';

class SeederFilmFahmi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> seedMoviesFahmi() async {
    List<MovieModelFahmi> movies = [
      MovieModelFahmi(
        movieId: "1",
        title: "Pengabdi Tampan",
        basePrice: 50000,
        posterUrl: "https://www.dreamers.id/img_editor/45709/images/pengabdi%20tampan.jpg",
        rating: 5,
        duration: 60,
      ),
      MovieModelFahmi(
        movieId: "2",
        title: "Pengenmi Instan",
        basePrice: 60000,
        posterUrl: "https://www.dreamers.id/img_editor/45709/images/pengen%20mi%20instan.jpg",
        rating: 4.7,
        duration: 65,
      ),
      MovieModelFahmi(
        movieId: "3",
        title: "Penagih Hutang 2",
        basePrice: 70000,
        posterUrl: "https://image.idntimes.com/post/20220808/fromandroid-50ee323cc9b57b4a94ce908b2380f2d2.jpg",
        rating: 4.2,
        duration: 130,
      ),
      MovieModelFahmi(
        movieId: "4",
        title: "Cari Loker Adalah Maut",
        basePrice: 50000,
        posterUrl: "https://assets.promediateknologi.id/crop/8x9:1050x1313/x/photo/p3/27/2024/07/01/WhatsApp-Image-2024-07-01-at-105029-2175365084.jpeg",
        rating: 4.9,
        duration: 90,
      ),
      MovieModelFahmi(
        movieId: "5",
        title: "Biawak",
        basePrice: 40000,
        posterUrl: "https://cdn-brilio-net.akamaized.net/news/2019/07/14/167182/1065119-1000xauto-biawak-poster-film-viral.jpg",
        rating: 5,
        duration: 100,
      ),
      MovieModelFahmi(
        movieId: "6",
        title: "Beauty And The Bis",
        basePrice: 60000,
        posterUrl: "https://dafunda.com/wp-content/uploads/2017/03/meme-poster-beauty-beast-2.jpg",
        rating: 4.2,
        duration: 60,
      ),
      MovieModelFahmi(
        movieId: "7",
        title: "Titaic",
        basePrice: 53000,
        posterUrl: "https://assets.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/radarjember/2022/07/FT-adv-koran.jpg",
        rating: 4.2,
        duration: 70,
      ),
      MovieModelFahmi(
        movieId: "8",
        title: "Dilan 1981",
        basePrice: 46000,
        posterUrl: "https://media.suara.com/pictures/original/2022/05/14/71465-foto-editan-ivan-gunawan-jadi-tokoh-film-instagramativan-gunawan.jpg",
        rating: 4.7,
        duration: 65,
      ),
      MovieModelFahmi(
        movieId: "9",
        title: "Cangkeman",
        basePrice: 50000,
        posterUrl: "https://awsimages.detik.net.id/community/media/visual/2022/08/16/poster-drama-korea-ala-sinetron-indonesia.jpeg?w=650&q=90",
        rating: 4.8,
        duration: 100,
      ),
      MovieModelFahmi(
        movieId: "10",
        title: "Terhalu Tampan",
        basePrice: 60000,
        posterUrl: "https://cdn1-production-images-kly.akamaized.net/jwzs8_xXmnTgHAn_Thm7aftOd2U=/500x667/smart/filters:quality(75):strip_icc()/kly-media-production/medias/2857557/original/054259500_1563497584-rt.jpg",
        rating: 5.0,
        duration: 90,
      ),
    ];

    for (var movie in movies) {
      await _db.collection(FirestoreCollectionsFahmi.moviesFahmi).doc(movie.movieId).set(movie.toMap());
    }
  }
}