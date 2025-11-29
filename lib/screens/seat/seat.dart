import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sss_cinema/models/movie.dart';
import 'package:sss_cinema/providers/seat.dart';
import 'package:sss_cinema/providers/booking.dart';
import 'package:sss_cinema/providers/auth.dart';
import 'package:sss_cinema/widgets/seat.dart';

class SeatScreen extends StatefulWidget {
  final MovieModel movie;
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
    final seatProvider = Provider.of<SeatProvider>(context, listen: false);
    seatProvider.loadSoldSeatsNaza(widget.movie.movieId);
  }

  List<String> _generateSeatIdsNaza() {
    List<String> list = [];
    for (int r = 0; r < rowsNaza; r++) {
      final rowLetter = String.fromCharCode('A'.codeUnitAt(0) + r);
      for (int c = 1; c <= colsNaza; c++) list.add('$rowLetter$c');
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final seatProvider = Provider.of<SeatProvider>(context);
    final bookingProvider = Provider.of<BookingProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final seats = _generateSeatIdsNaza();

    int totalNowNaza() {
      return bookingProvider.calculateTotalNaza(movieTitle: widget.movie.title, basePrice: widget.movie.basePrice, seats: seatProvider.selectedSeatsNaza);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Pilih Kursi - ${widget.movie.title}')),
      body: Column(children: [
        SizedBox(height: 12),
        Expanded(
          child: GridView.count(
            crossAxisCount: colsNaza,
            padding: EdgeInsets.all(12),
            children: seats.map((s) {
              final sold = seatProvider.isSoldNaza(s);
              final selected = seatProvider.isSelectedNaza(s);
              return SeatItemNaza(seatId: s, isSold: sold, isSelected: selected, onTap: (id) => seatProvider.toggleSeatNaza(id));
            }).toList(),
          ),
        ),
        Container(
          padding: EdgeInsets.all(12),
          child: Column(children: [
            Row(children: [Text('Dipilih: '), Expanded(child: Text(seatProvider.selectedSeatsNaza.join(', '))), Text('Total: Rp ${totalNowNaza()}')]),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: seatProvider.selectedSeatsNaza.isEmpty
                  ? null
                  : () async {
                      try {
                        final user = authProvider.user;
                        if (user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Silakan login')));
                          return;
                        }
                        final id = await bookingProvider.checkoutBookingRendra(userId: user.uid, movieId: widget.movie.movieId, movieTitle: widget.movie.title, seats: seatProvider.selectedSeatsNaza, basePrice: widget.movie.basePrice);
                        seatProvider.clearSelectedSeatsNaza();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking sukses: $id')));
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: ${e.toString()}')));
                      }
                    },
              child: Text('Checkout'),
            )
          ]),
        )
      ]),
    );
  }
}
