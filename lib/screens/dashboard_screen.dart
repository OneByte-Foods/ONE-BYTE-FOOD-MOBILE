import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/routes/app_routes.dart';
import 'package:One_Bytes_Food/screens/booking_screen.dart';
import 'package:One_Bytes_Food/screens/home_page_screen.dart';
import 'package:One_Bytes_Food/screens/profile_page_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    BookingScreen(),
    FavoritesPage(),
    ProfilePage()
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
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.qrCodeScannerScreen);
        },
        child: Icon(
          Icons.qr_code_scanner,
          color: Colors.white,
        ),
        backgroundColor: AppColors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 4.0,
        shape: CircularNotchedRectangle(),
        color: Colors.black87,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildBottomNavItem("assets/icons/home_icon.png", "Home", 0),
            buildBottomNavItem("assets/icons/table_icon.png", "Booking", 1),
            SizedBox(width: 0.5),
            buildBottomNavItem("assets/icons/board_icon.png", "Food", 2),
            buildBottomNavItem("assets/icons/person_icon.png", "Profile", 3),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  Widget buildBottomNavItem(String icon, String label, int index) {
    return Container(
      child: InkWell(
        onTap: () {
          _onItemTapped(index);
        },
        child: Container(
          padding: EdgeInsets.all(4.0),
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
                    color: index == _selectedIndex
                        ? AppColors.green
                        : Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Online Food Ordering System'),
      ),
    );
  }
}
