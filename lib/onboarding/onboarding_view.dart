import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/onboarding/onboarding_items.dart';
import 'package:One_Bytes_Food/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => OnBoardingViewState();
}

class OnBoardingViewState extends State<OnBoardingView> {
  bool isLastPage = false;
  final controller = OnboardingItems();
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: isLastPage
            ? getStarted(context, mounted)
            : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                  onPressed: () {
                    pageController.jumpToPage(controller.items.length - 1);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: AppColors.green),
                  ),
                ),
                SmoothPageIndicator(
                  onDotClicked: (index) {
                    pageController.animateToPage(index,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                  },
                  controller: pageController,
                  count: controller.items.length,
                  effect: WormEffect(
                    activeDotColor: AppColors.green,
                    dotColor: Color(0xffE6E6E6),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: SizedBox(
                      child: Image.asset('assets/icons/arrow.png'),
                    ))
              ]),
      ),
      body: Center(
        child: Container(
          child: PageView.builder(
            onPageChanged: (index) {
              isLastPage = controller.items.length - 1 == index;
              setState(() {});
            },
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image),
                  SizedBox(height: 15),
                  Text(
                    controller.items[index].title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      controller.items[index].description,
                      style: TextStyle(
                        color: Color(0xff4B5563),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget getStarted(BuildContext context, mounted) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: AppColors.green,
    ),
    width: MediaQuery.of(context).size.width * .9,
    height: 55,
    child: TextButton(
      onPressed: () async {
        final pres = await SharedPreferences.getInstance();
        pres.setBool('onboarding', true);

        if (!mounted) return;
        Navigator.pushNamed(context, AppRoutes.welcomeScreen);
      },
      child: Text(
        'Get Started',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}
