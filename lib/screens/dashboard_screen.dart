import 'package:One_Bytes_Food/bloc/cinema/cinema_bloc.dart';
import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/screens/home_page_screen.dart';
import 'package:One_Bytes_Food/screens/seat_reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

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
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    if (index == 4) {
      payWithKhaltiInApp();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.qr_code_scanner_rounded),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
      ),
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
            buildBottomNavItem("assets/icons/person_icon.png", "Setting", 3),
            buildBottomNavItem("assets/icons/person_icon.png", "Khalti", 4),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  Widget buildBottomNavItem(String icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            scale: 2,
            icon,
            color: index == _selectedIndex ? AppColors.green : AppColors.white,
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
    );
  }

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: 1000, //in paisa
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

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
