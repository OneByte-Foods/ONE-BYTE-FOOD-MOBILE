import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/screens/menu/menu_view.dart';
import 'package:One_Bytes_Food/screens/seat_reservation_screen.dart';
import 'package:flutter/material.dart';

class ModeScreen extends StatefulWidget {
  final String restaurantName;

  const ModeScreen({Key? key, required this.restaurantName}) : super(key: key);

  @override
  State<ModeScreen> createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  final List<Map<String, String>> servicesArr = [
    {
      "name": "Online Food Order",
      "description":
          "Order your favorite food online and get it delivered to your doorstep.",
      "image": "assets/img/menu_1.png",
    },
    {
      "name": "Dining Reservation",
      "description":
          "Reserve a table at your favorite restaurant for a delightful dining experience.",
      "image": "assets/img/menu_2.png",
    },
  ];

  final List<List<Color>> gradients = [
    [Colors.greenAccent, Colors.greenAccent.shade700],
    [Colors.pinkAccent, Colors.orangeAccent],
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Text(widget.restaurantName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset("assets/img/btn_back.png",
                          width: 20, height: 20),
                    ),
                    const SizedBox(width: 30),
                    Text(
                      "Our Services",
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: servicesArr.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> mObj = entry.value;
                  var name = mObj["name"]!;
                  var description = mObj["description"]!;
                  var image = mObj["image"]!;
                  var gradientColors = gradients[index % gradients.length];

                  return GestureDetector(
                    onTap: () {
                      if (name == "Online Food Order") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MenuView(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SeatReservationScreen(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  description,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
