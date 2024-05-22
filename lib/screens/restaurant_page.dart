import 'package:One_Bytes_Food/constants/app_style.dart';
import 'package:One_Bytes_Food/screens/online_offline_page.dart';
import 'package:flutter/material.dart';

import '../widgets/menu_item_row.dart';
import '../widgets/rounded_textfiled.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  TextEditingController searchText = TextEditingController();
  List menuItemsArr = [
    {
      "image": "assets/img/lavie_garden.jpg",
      "name": "Lavie Garden",
      "rate": "3.2",
      "rating": "124",
      "type": "Minute by tuk tuk",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/alia.jpg",
      "name": "AILA RESTAURANT AND LOUNGE",
      "rate": "5.0",
      "rating": "124",
      "type": "Cakes by Tella",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/hyatt.jpg",
      "name": "Hyatt RESTAURANT",
      "rate": "3.9",
      "rating": "124",
      "type": "Café Racer",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/bhojan.jpg",
      "name": "BHOJAN GRIHA",
      "rate": "4.9",
      "rating": "124",
      "type": "Minute by tuk tuk",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/jimbu.jpg",
      "name": "Jimbu Thakali",
      "rate": "5.9",
      "rating": "124",
      "type": "Minute by tuk tuk",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/solatee.jpg",
      "name": "The Soaltee Hotel",
      "rate": "3.9",
      "rating": "124",
      "type": "Cakes by Tella",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/krishna.jpg",
      "name": "Krishnarpan Nepali Restaurant",
      "rate": "5.0",
      "rating": "124",
      "type": "Café Racer",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/garden.jpeg",
      "name": "Garden of Dreams",
      "rate": "4.9",
      "rating": "124",
      "type": "Minute by tuk tuk",
      "food_type": "Desserts"
    },
  ];
  List filteredMenuItems = [];

  @override
  void initState() {
    super.initState();
    filteredMenuItems = menuItemsArr;
  }

  void filterMenuItems(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMenuItems = menuItemsArr;
      } else {
        filteredMenuItems = menuItemsArr
            .where((item) =>
                item['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                "Restaurants",
                style: AppStyles.text18PxRegular,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: RoundTextfield(
                  hintText: "Search Restaurant",
                  controller: searchText,
                  left: Container(
                    alignment: Alignment.center,
                    width: 30,
                    child: Image.asset(
                      "assets/img/search.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                  onChanged: filterMenuItems,
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: filteredMenuItems.length,
                itemBuilder: ((context, index) {
                  var mObj = filteredMenuItems[index] as Map? ?? {};
                  return MenuItemRow(
                    mObj: mObj,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModeScreen(
                            restaurantName: mObj['name'],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
