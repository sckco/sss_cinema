import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:sss_cinema/providers/auth_fahmi.dart';
import 'package:sss_cinema/models/user_fahmi.dart';
import 'package:sss_cinema/providers/booking_rendra.dart';
import 'package:sss_cinema/models/booking_fahmi.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreenFahmi extends StatefulWidget {
  const ProfileScreenFahmi({super.key});

  @override
  State<ProfileScreenFahmi> createState() => _ProfileScreenFahmiState();
}

class _ProfileScreenFahmiState extends State<ProfileScreenFahmi> {
  late Future<List<BookingModelFahmi>> _bookingsFuture;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProviderFahmi>(context, listen: false);
    final userId = authProvider.currentUserFahmi?.uid ?? '';
    final bookingProvider = Provider.of<BookingProvider>(
      context,
      listen: false,
    );
    _bookingsFuture = bookingProvider.getBookingsByUser(userId);
  }

  String _extractName(dynamic user) {
    if (user == null) return '-';
    if (user is UserModelFahmi) return user.name;
    if (user is User) return user.displayName ?? user.email ?? '-';
    if (user is Map)
      return (user['name'] ?? user['displayName'] ?? user['email'] ?? '-')
          .toString();
    try {
      final v =
          user.name ?? user.displayName ?? user['name'] ?? user['displayName'];
      return v?.toString() ?? '-';
    } catch (_) {
      return '-';
    }
  }

  String _extractEmail(dynamic user) {
    if (user == null) return '-';
    if (user is UserModelFahmi) return user.email;
    if (user is User) return user.email ?? '-';
    if (user is Map) return (user['email'] ?? '-').toString();
    try {
      final v = user.email ?? user['email'];
      return v?.toString() ?? '-';
    } catch (_) {
      return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderFahmi>(context);
    final dynamic user = authProvider.currentUserFahmi;

    final name = _extractName(user);
    final email = _extractEmail(user);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.person, color: Colors.white, size: 50),
            ),
            const SizedBox(height: 20),
            Text(
              "Nama: $name",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              "Email: $email",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              "Riwayat Booking:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<BookingModelFahmi>>(
                future: _bookingsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Error loading bookings',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No bookings found',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    final bookings = snapshot.data!;
                    return ListView.builder(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        final booking = bookings[index];
                        final date = DateFormat(
                          'yyyy-MM-dd HH:mm',
                        ).format(booking.bookingDate.toDate());
                        return Card(
                          color: Colors.grey[800],
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.black,
                                    title: const Text(
                                      'QR Code Booking',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: QrImageView(
                                        data: booking.bookingId,
                                        version: QrVersions.auto,
                                        size: 200.0,
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            title: Text(
                              booking.movieTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Seats: ${booking.seats.join(', ')}',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  'Total Price: Rp ${booking.totalPrice}',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  'Date: $date',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  await authProvider.logoutFahmi();
                  Navigator.pushReplacementNamed(context, "/login");
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
