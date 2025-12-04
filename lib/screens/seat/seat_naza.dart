import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sss_cinema/models/movie_fahmi.dart';
import 'package:sss_cinema/providers/seat_naza.dart';
import 'package:sss_cinema/providers/booking_naza_rendra.dart';
import 'package:sss_cinema/providers/auth_fahmi.dart';
import 'package:sss_cinema/widgets/seat_naza.dart';

class SeatScreen extends StatefulWidget {
  final MovieModelFahmi movie;
  const SeatScreen({super.key, required this.movie});

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  final int rows = 6;
  final int cols = 8;

  @override
  void initState() {
    super.initState();
    Provider.of<SeatProvider>(
      context,
      listen: false,
    ).listenSoldSeatsRealtime(widget.movie.movieId);
  }

  void showPaymentSuccessPopup() {
    final overlay = OverlayEntry(
      builder: (context) => Positioned(
        top: 120,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 40),
                  SizedBox(height: 10),
                  Text(
                    "Pemesanan Berhasil!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Tiket berhasil dipesan.",
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlay);
    Future.delayed(const Duration(seconds: 2), () => overlay.remove());
  }

  List<String> generateSeats() {
    List<String> s = [];
    for (int r = 0; r < rows; r++) {
      String row = String.fromCharCode(65 + r);
      for (int c = 1; c <= cols; c++) {
        s.add("$row$c");
      }
    }
    return s;
  }

  @override
  Widget build(BuildContext context) {
    final seatProv = Provider.of<SeatProvider>(context);
    final bookProv = Provider.of<BookingProviderRendra>(context);
    final auth = Provider.of<AuthProviderFahmi>(context);

    final user = auth.currentUserFahmi;
    if (user != null && !seatProv.selectedSeatsLoaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        seatProv.loadSelectedSeats(user.uid, widget.movie.movieId);
      });
    }

    final seats = generateSeats();

    final total = bookProv.calculateTotalRendra(
      movieTitle: widget.movie.title,
      basePrice: widget.movie.basePrice,
      seats: seatProv.selectedSeatsNaza,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Pilih Kursi - ${widget.movie.title}",
          style: const TextStyle(color: Colors.redAccent),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF1A0000), Color(0xFF300000)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          children: [
            const SizedBox(height: 10),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(18),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                ),
                itemCount: seats.length,
                itemBuilder: (_, i) {
                  final id = seats[i];
                  return Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.3),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: SeatItemNaza(
                      seatId: id,
                      isSold: seatProv.isSoldNaza(id),
                      isSelected: seatProv.isSelectedNaza(id),
                      onTap: (s) => seatProv.toggleSeatNaza(s),
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Dipilih: ${seatProv.selectedSeatsNaza.join(', ')}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 6),

                  Text(
                    "Total: Rp $total",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: seatProv.selectedSeatsNaza.isEmpty
                        ? null
                        : () async {
                            final user = auth.currentUserFahmi;
                            if (user == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Silakan login terlebih dahulu",
                                  ),
                                ),
                              );
                              return;
                            }

                            final bookingId = await bookProv.checkoutBookingRendra(
                              userId: user.uid,
                              movieId: widget.movie.movieId,
                              movieTitle: widget.movie.title,
                              basePrice: widget.movie.basePrice,
                              seats: seatProv.selectedSeatsNaza,
                            );

                            if (bookingId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Kursi yang dipilih sudah tidak tersedia. Silakan pilih kursi lain.",
                                  ),
                                ),
                              );
                              return;
                            }

                            seatProv.clearSelectedSeatsNaza();
                            showPaymentSuccessPopup();

                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.pop(context);
                            });
                          },

                    child: const Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
