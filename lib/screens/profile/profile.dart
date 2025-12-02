import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sss_cinema/providers/auth.dart';
import 'package:sss_cinema/services/firestore.dart';
import 'package:sss_cinema/models/booking.dart';
import 'package:sss_cinema/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  final FirestoreServiceFahmi _firestoreService = FirestoreServiceFahmi();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProviderFahmi>(context);
    final user = auth.currentUserFahmi;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text('Belum login')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => auth.logoutFahmi(),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(user.displayName ?? "Tanpa Nama"),
            subtitle: Text(user.email ?? ""),
          ),

          Expanded(
            child: StreamBuilder<List<BookingModelFahmi>>(
              stream: _streamUserBookings(user.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final bookings = snapshot.data!;
                if (bookings.isEmpty) {
                  return Center(child: Text("Belum ada riwayat booking"));
                }

                return ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final b = bookings[index];
                    return Card(
                      child: ListTile(
                        title: Text(b.movieTitle),
                        subtitle: Text(
                          '${b.seats.join(', ')}\nRp ${b.totalPrice}',
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: Icon(Icons.qr_code),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('QR Booking'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    QrImageView(
                                      data: b.bookingId,
                                      version: QrVersions.auto,
                                      size: 200,
                                    ),
                                    SizedBox(height: 8),
                                    Text(b.bookingId),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Stream bookings by user (dibuat manual karena service kamu belum menyediakan stream)
  Stream<List<BookingModelFahmi>> _streamUserBookings(String userId) {
    return FirebaseFirestore.instance
        .collection(FirestoreCollectionsFahmi.bookingsFahmi)
        .where('user id', isEqualTo: userId)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => BookingModelFahmi.fromMap(d.data())).toList());
  }
}
