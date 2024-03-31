import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/widgets/bottom_modal_sheet.dart';
import 'package:One_Bytes_Food/widgets/build_btn.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController = TabController(
    length: 2,
    vsync: this,
  );
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
              modalBottomSheet(context, _tabController);
              // Navigator.pushNamed(context, AppRoutes.signUpPage);
            },
          ),
          SizedBox(height: 10),
          buildButton(
            context,
            text: 'Login',
            color: AppColors.pitchGreenColor,
            textColor: AppColors.pitchGreenLightColor,
            onPressed: () {
              modalBottomSheet(context, _tabController);

              // Navigator.pushNamed(context, AppRoutes.loginPageScreen);
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
