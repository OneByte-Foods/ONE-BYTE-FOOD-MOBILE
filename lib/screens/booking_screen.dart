import 'package:One_Bytes_Food/constants/app_style.dart';
import 'package:One_Bytes_Food/model/booking_model.dart';
import 'package:One_Bytes_Food/widgets/circle_avatar_widget.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late Future<List<Booking>> bookingsFuture;
  List<Booking> _bookings = [];

  @override
  void initState() {
    super.initState();
    bookingsFuture = getStaticBookings();
    bookingsFuture.then((bookings) {
      setState(() {
        _bookings = bookings;
      });
    });
  }

  Future<List<Booking>> getStaticBookings() async {
    // Static booking data with required parameters
    return [
      Booking(
        id: '1',
        tableType: 'Window',
        seatNumber: 1,
        status: 'Confirmed',
        userProfilePic: 'https://example.com/profile1.jpg',
        userEmail: 'user1@example.com',
        userName: 'User One',
      ),
      Booking(
        id: '2',
        tableType: 'Center',
        seatNumber: 2,
        status: 'Pending',
        userProfilePic: 'https://example.com/profile2.jpg',
        userEmail: 'user2@example.com',
        userName: 'User Two',
      ),
      Booking(
        id: '3',
        tableType: 'Corner',
        seatNumber: 3,
        status: 'Cancelled',
        userProfilePic: 'https://example.com/profile3.jpg',
        userEmail: 'user3@example.com',
        userName: 'User Three',
      ),
      Booking(
        id: '3',
        tableType: 'Corner',
        seatNumber: 3,
        status: 'Cancelled',
        userProfilePic: 'https://example.com/profile3.jpg',
        userEmail: 'user3@example.com',
        userName: 'User Three',
      ),
      Booking(
        id: '3',
        tableType: 'Corner',
        seatNumber: 3,
        status: 'Cancelled',
        userProfilePic: 'https://example.com/profile3.jpg',
        userEmail: 'user3@example.com',
        userName: 'User Three',
      ),
      Booking(
        id: '3',
        tableType: 'Corner',
        seatNumber: 3,
        status: 'Cancelled',
        userProfilePic: 'https://example.com/profile3.jpg',
        userEmail: 'user3@example.com',
        userName: 'User Three',
      ),
      Booking(
        id: '3',
        tableType: 'Corner',
        seatNumber: 3,
        status: 'Cancelled',
        userProfilePic: 'https://example.com/profile3.jpg',
        userEmail: 'user3@example.com',
        userName: 'User Three',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Booking',
          style: AppStyles.text18PxRegular,
        ),
        centerTitle: true, // Booking title
      ),
      body: FutureBuilder<List<Booking>>(
        future: bookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No bookings found.'));
          } else {
            return ListView.builder(
              itemCount:
                  snapshot.data!.length, 
              itemBuilder: (context, index) {
                Booking booking =
                    snapshot.data![index];
                return ListTile(
                  leading: booking.userProfilePic != null
                      ? buildCircleAvatar(radius: 25)
                      : CircleAvatar(child: Icon(Icons.person)),
                  title: Text(
                      '${booking.tableType} - Seat: ${booking.seatNumber}'),
                  subtitle: Text('Status: ${booking.status}'),
                  trailing: IconButton(
                    icon: Icon(Icons.undo),
                    onPressed: () {
                      setState(() {
                        _bookings.removeAt(
                            index); // Make sure to update _bookings if necessary
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
