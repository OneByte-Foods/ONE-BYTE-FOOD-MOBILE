import 'package:flutter/material.dart';
import 'package:new_mobile_app/forgot%20password/forgot_password.dart';
import 'package:new_mobile_app/home/home_screen.dart';
import 'package:new_mobile_app/login/login_page.dart';
import 'package:new_mobile_app/onboarding/onboarding_view.dart';
import 'package:new_mobile_app/screens/welcome_screen.dart';
import 'package:new_mobile_app/seat%20reservation/screen/seat_reservation_screen.dart';
import 'package:new_mobile_app/signup/signup_screen.dart';

class AppRoutes {
// route names

  static const String onBoardingScreen = '/on-boarding-screen';
  static const String signUpPage = '/Signup-page-screen';
  static const String loginPageScreen = '/login-page-screen';
  static const String homePageScreen = '/home-page-screen';
  static const String forgotPasswordScreen = '/forgot-password-page-screen';
  static const String seatReservationScreen = '/seat-reservation-screen';
  static const String welcomeScreen = '/welcome-screen';

  static Map<String, WidgetBuilder> routes = {
    onBoardingScreen: (context) => OnBoardingView(),
    signUpPage: (context) => SignupScreen(),
    loginPageScreen: (context) => LoginPageScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    homePageScreen: (context) => HomeScreen(),
    welcomeScreen: (context) => WelcomeScreen(),
    seatReservationScreen: (context) =>
        SeatReservationScreen(titleMovie: "Seat Reservation"),
  };
}
