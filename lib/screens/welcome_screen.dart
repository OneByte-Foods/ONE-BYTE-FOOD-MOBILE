import 'package:flutter/material.dart';
import 'package:new_mobile_app/constants/global_colors.dart';
import 'package:new_mobile_app/login/login_page.dart';
import 'package:new_mobile_app/signup/signup_screen.dart';
import 'package:new_mobile_app/widgets/build_btn.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _popSignup(BuildContext context) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 10),
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.fixed,
      content: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(50), // Adjust the border radius as needed
          color: Colors.white, // Add a background color if needed
        ),
        height: 600,
        width: 400,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          children: [
            SignupScreen(),
            LoginPageScreen(),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Image.asset(
              "assets/images/order_sucess.png",
              width: 280,
              height: 224.99,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Welcome",
            style: TextStyle(
              fontSize: 24,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Before Enjoying Onebytes Services\nPlease Register First",
            style: TextStyle(
              color: Color(0xff4B5563),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 150),
          buildButton(
            context,
            text: 'Get Started',
            color: AppColors.green,
            onPressed: () {
              _popSignup(context);
            },
          ),
          SizedBox(height: 10),
          buildButton(
            context,
            text: 'Login',
            color: AppColors.pitchGreenColor,
            textColor: AppColors.pitchGreenLightColor,
            onPressed: () {
              // Add your logic here
            },
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text:
                        'By logging in or registering, you have agreed to the ',
                  ),
                  TextSpan(
                    text: 'Terms and Conditions',
                    style: TextStyle(color: Colors.green),
                  ),
                  TextSpan(
                    text: ' and ',
                  ),
                  TextSpan(
                    text: 'Privacy Policy.',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
