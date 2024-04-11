import 'package:One_Bytes_Food/constants/app_style.dart';
import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/provider/location_provider.dart';
import 'package:One_Bytes_Food/widgets/circle_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/search_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Provider.of<LocationProvider>(context, listen: false).updateLocation();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ModernSearchBar(),
            ],
          ),
          SizedBox(height: 40),
          SizedBox(
            height: 120,
            child: _buildCarousel(),
          ),
          SizedBox(height: 20),
          SmoothPageIndicator(
            onDotClicked: (index) {
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 400), curve: Curves.easeIn);
            },
            controller: _pageController,
            count: 2,
            effect: WormEffect(
              strokeWidth: 15,
              dotHeight: 15,
              activeDotColor: AppColors.green,
              dotColor: Color(0xffE6E6E6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return ListView(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(width: 20),
        _buildFirstPage(),
        SizedBox(width: 20),
        _buildSecondPage(),
        SizedBox(width: 30),
      ],
    );
  }

  Widget _buildFirstPage() {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(colors: [
          Color.fromARGB(198, 255, 160, 6),
          Color(0xffFFE1B4),
        ]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/small_burger.png",
                  width: 44,
                  height: 26,
                ),
                Text("Flash Offer",
                    style: AppStyles.text16PxBold.copyWith(
                      color: Colors.white,
                    )),
                Text("We are here with the best \ndeserts intown.",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    )),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Order",
                        style: AppStyles.text8PxBold.copyWith(
                          color: Colors.white,
                        )),
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 10)
                  ],
                )
              ],
            ),
          ),
          Image.asset(
            "assets/images/burger.png",
            width: 135,
            height: 117,
          )
        ],
      ),
    );
  }

  Widget _buildSecondPage() {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(colors: [
            Color(0xff32B768),
            Color(0xffB3FFD1),
          ]),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Image.asset(
                      "assets/images/small_pizza.png",
                      width: 38,
                      height: 38,
                    ),
                  ),
                  Text("New Arrival",
                      style: AppStyles.text16PxBold.copyWith(
                        color: Colors.white,
                      )),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "We are here with the best \ndeserts intown.",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Order",
                          style: AppStyles.text8PxBold.copyWith(
                            color: Colors.white,
                          )),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 10),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Image.asset(
                "assets/images/pizza.png",
                width: 150,
                height: 165,
              ),
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      leading: Image.asset(
        "assets/icons/drawer_icon.png",
        width: 20,
      ),
      backgroundColor: AppColors.scaffoldBackgroundColor,
      title: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          print("Location -> " + locationProvider.currentLocation);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 30),
                  Image.asset(
                    "assets/icons/location_icon.png",
                    width: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    locationProvider.currentLocation,
                    style: AppStyles.text12PxRegular,
                  ),
                ],
              ),
              buildCircleAvatar(radius: 15)
            ],
          );
        },
      ),
    );
  }
}
