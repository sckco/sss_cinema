import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sss_cinema/models/movie.dart';
import 'package:sss_cinema/providers/seat.dart';
import 'package:sss_cinema/providers/booking.dart';
import 'package:sss_cinema/providers/auth.dart';
import 'package:sss_cinema/widgets/seat.dart';

class SeatScreen extends StatefulWidget {
  final MovieModelFahmi movie;
  const SeatScreen({required this.movie});

  @override
  _SeatScreenState createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  final int rowsNaza = 6;
  final int colsNaza = 8;

  @override
  void initState() {
    super.initState();
    Provider.of<SeatProvider>(
      context,
      listen: false,
    ).loadSoldSeatsNaza(widget.movie.movieId);
  }

  List<String> _generateSeatIdsNaza() {
    List<String> list = [];
    for (int r = 0; r < rowsNaza; r++) {
      final rowLetter = String.fromCharCode('A'.codeUnitAt(0) + r);
      for (int c = 1; c <= colsNaza; c++) {
        list.add('$rowLetter$c');
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final seatProvider = Provider.of<SeatProvider>(context);
    final bookingProvider = Provider.of<BookingProvider>(context);
    final authProvider = Provider.of<AuthProviderFahmi>(context);

    final seats = _generateSeatIdsNaza();

    int totalNowNaza() {
      return bookingProvider.calculateTotalNaza(
        movieTitle: widget.movie.title,
        basePrice: widget.movie.basePrice,
        seats: seatProvider.selectedSeatsNaza,
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Pilih Kursi - ${widget.movie.title}",
          style: const TextStyle(color: Colors.redAccent),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 12),

          Expanded(
            child: GridView.count(
              crossAxisCount: colsNaza,
              padding: const EdgeInsets.all(12),
              children: seats.map((s) {
                final sold = seatProvider.isSoldNaza(s);
                final selected = seatProvider.isSelectedNaza(s);

                return SeatItemNaza(
                  seatId: s,
                  isSold: sold,
                  isSelected: selected,
                  onTap: seatProvider.toggleSeatNaza,
                );
              }).toList(),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Color(0xFF111111),
              border: Border(top: BorderSide(color: Colors.redAccent)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Dipilih: ",
                      style: TextStyle(color: Colors.white),
                    ),
                    Expanded(
                      child: Text(
                        seatProvider.selectedSeatsNaza.join(', '),
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                    Text(
                      "Total: Rp ${totalNowNaza()}",
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: seatProvider.selectedSeatsNaza.isEmpty
                        ? null
                        : () async {
                            try {
                              final user = authProvider.currentUserFahmi;
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

                              final id = await bookingProvider
                                  .checkoutBookingRendra(
                                    userId: user.uid,
                                    movieId: widget.movie.movieId,
                                    movieTitle: widget.movie.title,
                                    seats: seatProvider.selectedSeatsNaza,
                                    basePrice: widget.movie.basePrice,
                                  );

                              seatProvider.clearSelectedSeatsNaza();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Booking berhasil: $id"),
                                ),
                              );

                              Navigator.pop(context);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          },
                    child: const Text(
                      "Checkout",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
