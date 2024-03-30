import 'package:flutter/material.dart';
import 'package:new_mobile_app/constants/global_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 80),
              child: Image.asset(
                "assets/images/order_sucess.png",
                width: 280,
                height: 224.99,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Welcome",
            style: TextStyle(
                fontSize: 24,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Before Enjoying Onebytes Services \n Please Register First",
            style: TextStyle(
              color: Color(0xff4B5563),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 150,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.green,
            ),
            width: MediaQuery.of(context).size.width * .7,
            height: 49,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.pitchGreenColor,
            ),
            width: MediaQuery.of(context).size.width * .7,
            height: 49,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Login',
                style: TextStyle(
                  color: AppColors.pitchGreenLightColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Text.rich(
              textAlign: TextAlign.center,
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
            ),
          )
        ],
      ),
    );
  }
}
