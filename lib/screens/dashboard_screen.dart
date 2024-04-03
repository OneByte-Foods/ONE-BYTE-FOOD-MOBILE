import 'package:One_Bytes_Food/bloc/cinema/cinema_bloc.dart';
import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/screens/home_page_screen.dart';
import 'package:One_Bytes_Food/screens/seat_reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'profile_page_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    BlocProvider<CinemaBloc>(
      create: (context) => CinemaBloc(),
      child: SeatReservationScreen(
        titleMovie: "Seat Reservation",
      ),
    ),
    FavoritesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if (index == index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: CircularNotchedRectangle(),
        color: Colors.black87,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            buildBottomNavItem("assets/icons/home_icon.png", "Home", 0),
            buildBottomNavItem("assets/icons/board_icon.png", "Shop", 1),
            buildBottomNavItem("assets/icons/table_icon.png", "Booking", 2),
            buildBottomNavItem("assets/icons/person_icon.png", "Profile", 3),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  Widget buildBottomNavItem(String icon, String label, int index) {
    return Container(
      child: GestureDetector(
        onTap: () {
          _onItemTapped(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              scale: 2,
              icon,
              color:
                  index == _selectedIndex ? AppColors.green : AppColors.white,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                  color:
                      index == _selectedIndex ? AppColors.green : Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: 1000,
        productIdentity: 'Product Id',
        productName: 'Product Name',
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          actions: [
            SimpleDialogOption(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(
      failure.toString(),
    );
  }

  void onCancel() {
    debugPrint('Cancelled');
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Favorites Page'),
      ),
    );
  }
}
