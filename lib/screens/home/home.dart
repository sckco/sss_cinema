import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sss_cinema/providers/auth.dart';
import 'package:sss_cinema/providers/movie.dart';
import 'package:sss_cinema/widgets/movie.dart';
import 'package:sss_cinema/models/movie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerDaniel = Provider.of<MovieProvider>(context);
    final authProvider = Provider.of<AuthProviderFahmi>(context, listen: false);

    // Jalankan loadMovies setelah frame pertama
    WidgetsBinding.instance.addPostFrameCallback((_) {
      providerDaniel.loadMoviesDaniel();
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "SSS Cinema",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Konfirmasi logout
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Konfirmasi Logout"),
                  content: const Text("Apakah Anda yakin ingin logout?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Batal"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Logout"),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await authProvider.logoutFahmi();
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => providerDaniel.loadMoviesDaniel(),
        color: Colors.white,
        backgroundColor: Colors.black,
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
          itemCount: providerDaniel.movieListDaniel.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 18,
            crossAxisSpacing: 18,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) {
            final movieDaniel = providerDaniel.movieListDaniel[index];
            return MovieItemWidget(movieDaniel: movieDaniel);
          },
        ),
      ),
    );
  }
}
