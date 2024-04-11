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
  late PageController _itemsPageController;
  int currentPage = 0;
  List<Widget> pages = [];
  List<Widget> items = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _itemsPageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<LocationProvider>(context, listen: false).updateLocation();

    // populate items dynamically
    items = [
      _buildItems("assets/images/biriyani.png", "Chicken Biryani",
          "Ambrosia Hotel & Restaurant"),
      _buildItems("assets/images/susi.png", "Sauce Tonkatsu",
          "Handi Restaurant,Chittagong"),
      _buildItems("assets/images/katsu.png", "Chicken Katsu",
          "Ambrosia Hotel & Restaurant"),
    ];

    // Populate pages dynamically
    pages = [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildPage(
          "Flash Offer",
          "We are here with the best \ndesserts in town.",
          "assets/images/small_burger.png",
          "assets/images/burger.png",
          LinearGradient(
            colors: [Color.fromARGB(198, 255, 160, 6), Color(0xffFFE1B4)],
          ),
        ),
      ),
      _buildPage(
        "New Arrival",
        "We are here with the best \ndesserts in town.",
        "assets/images/small_pizza.png",
        "assets/images/pizza.png",
        LinearGradient(
          colors: [Color(0xff32B768), Color(0xffB3FFD1)],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 40),
        child: _buildPage(
          "Flash Offer",
          "We are here with the best \ndesserts in town.",
          "assets/images/small_burger.png",
          "assets/images/burger.png",
          LinearGradient(
            colors: [Color.fromARGB(198, 255, 160, 6), Color(0xffFFE1B4)],
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ModernSearchBar(),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 120,
              child: _buildCarousel(),
            ),
            SizedBox(height: 20),
            SmoothPageIndicator(
              onDotClicked: (index) {
                _pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                );
              },
              controller: _pageController,
              count: pages.length,
              effect: WormEffect(
                dotHeight: 8,
                activeDotColor: AppColors.green,
                dotColor: Color(0xffE6E6E6),
              ),
            ),
            _buildDescription("Today New Arivable",
                "Best of the today food list update", "See All"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 120,
                child: _buildItemsCarousel(),
              ),
            ),
            _buildDescription("Explore Restaurant",
                "Check your city Near by Restaurant", "See All"),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(
    String title,
    String description,
    String btnText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.text16PxBold,
              ),
              Text(
                description,
                style: AppStyles.text14PxLight,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                btnText,
                style: AppStyles.text12PxRegular
                    .copyWith(color: Color(0xff6B7280)),
              ),
              SizedBox(width: 5),
              Icon(Icons.arrow_forward_ios, color: Color(0xff6B7280), size: 15)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return ListView.builder(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: pages.length,
      itemBuilder: (context, index) => pages[index],
    );
  }

  Widget _buildItemsCarousel() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) => items[index],
    );
  }

  Widget _buildItems(
    String imgUrl,
    String title,
    String location,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: BoxConstraints(maxHeight: 400),
        width: 148,
        height: 196,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                imgUrl,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: AppStyles.text16PxSemiBold,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/location_icon.png",
                    width: 20,
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      location,
                      style: AppStyles.text10PxRegular,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(
    String title,
    String description,
    String smallImage,
    String bigImage,
    LinearGradient gradient,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: gradient,
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
                  smallImage,
                  width: 44,
                  height: 26,
                ),
                Text(
                  title,
                  style: AppStyles.text16PxBold.copyWith(color: Colors.white),
                ),
                Text(
                  description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Order",
                      style:
                          AppStyles.text8PxBold.copyWith(color: Colors.white),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 10)
                  ],
                )
              ],
            ),
          ),
          bigImage == "assets/images/pizza.png"
              ? Container(
                  padding: EdgeInsets.only(bottom: 18),
                  child: Image.asset(
                    bigImage,
                    width: 135,
                    height: 117,
                  ),
                )
              : Image.asset(
                  bigImage,
                  width: 135,
                  height: 117,
                )
        ],
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
