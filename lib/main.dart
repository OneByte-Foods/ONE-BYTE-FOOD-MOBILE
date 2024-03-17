import 'package:flutter/material.dart';
import 'package:new_mobile_app/login/login_page.dart';
import 'package:new_mobile_app/onboarding/onboarding_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OnBoardingView(),
      routes: {
        OnBoardingView.routeName: (context) => const OnBoardingView(),
        LoginPageScreen.routeName: (context) => const LoginPageScreen(),
      },
    );
  }
}
