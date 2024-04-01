import 'package:One_Bytes_Food/onboarding/onboarding_view.dart';
import 'package:One_Bytes_Food/screens/dashboard_screen.dart';
import 'package:One_Bytes_Food/screens/forgot_password.dart';
import 'package:One_Bytes_Food/screens/login_page.dart';
import 'package:One_Bytes_Food/screens/seat_reservation_screen.dart';
import 'package:One_Bytes_Food/screens/signup_screen.dart';
import 'package:One_Bytes_Food/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../screens/back_email_screen.dart';

class AppRoutes {
// route names

  static const String onBoardingScreen = '/on-boarding-screen';
  static const String signUpPage = '/Signup-page-screen';
  static const String loginPageScreen = '/login-page-screen';
  static const String homePageScreen = '/home-page-screen';
  static const String forgotPasswordScreen = '/forgot-password-page-screen';
  static const String seatReservationScreen = '/seat-reservation-screen';
  static const String welcomeScreen = '/welcome-screen';
  static const String backEmailScreen = '/back-email-screen';

  static Map<String, WidgetBuilder> routes = {
    onBoardingScreen: (context) => OnBoardingView(),
    signUpPage: (context) => SignupScreen(),
    loginPageScreen: (context) => LoginPageScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    homePageScreen: (context) => DashboardScreen(),
    welcomeScreen: (context) => WelcomeScreen(),
    backEmailScreen: (context) => BackEmailScreen(),
    seatReservationScreen: (context) =>
        SeatReservationScreen(titleMovie: "Seat Reservation"),
  };
}
