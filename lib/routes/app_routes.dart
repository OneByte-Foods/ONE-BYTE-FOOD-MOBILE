import 'package:flutter/material.dart';
import 'package:new_mobile_app/login/login_page.dart';
import 'package:new_mobile_app/onboarding/onboarding_view.dart';
import 'package:new_mobile_app/signup/signup_screen.dart';

class AppRoutes {
// route names

  static const String onBoardingScreen = '/on-boarding-screen';
  static const String signUpPage = '/Signup-page-screen';
  static const String loginPageScreen = '/login-page-screen';

  static Map<String, WidgetBuilder> routes = {
    onBoardingScreen: (context) => OnBoardingView(),
    signUpPage: (context) => SignupScreen(),
    loginPageScreen: (context) => LoginPageScreen(),
  };
}
