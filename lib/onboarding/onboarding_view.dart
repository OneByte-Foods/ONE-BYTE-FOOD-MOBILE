import 'package:flutter/material.dart';
import 'package:new_mobile_app/login/login_page.dart';
import 'package:new_mobile_app/onboarding/onboarding_items.dart';
import 'package:new_mobile_app/routes/app_routes.dart';
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
                  child: Text('Skip'),
                ),
                SmoothPageIndicator(
                  onDotClicked: (index) {
                    pageController.animateToPage(index,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                  },
                  controller: pageController,
                  count: controller.items.length,
                  effect: WormEffect(activeDotColor: Colors.purple),
                ),
                TextButton(
                  onPressed: () {
                    pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  },
                  child: Text('Next'),
                )
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
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    controller.items[index].description,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
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
      color: Colors.purple,
    ),
    width: MediaQuery.of(context).size.width * .9,
    height: 55,
    child: TextButton(
      onPressed: () async {
        final pres = await SharedPreferences.getInstance();
        pres.setBool('onboarding', true);

        if (!mounted) return;
        Navigator.pushNamed(context, AppRoutes.loginPageScreen);
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
