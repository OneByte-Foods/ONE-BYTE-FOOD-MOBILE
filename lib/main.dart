import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_mobile_app/firebase_options.dart';
import 'package:new_mobile_app/home/home_screen.dart';
import 'package:new_mobile_app/login/login_page.dart';
import 'package:new_mobile_app/onboarding/onboarding_view.dart';
import 'package:new_mobile_app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding') ?? false;
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(
    onboarding: onboarding,
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  final bool isLoggedIn;
  const MyApp({super.key, this.onboarding = false, this.isLoggedIn = false})
      : super();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget initialRoute;
    if (isLoggedIn) {
      initialRoute = HomeScreen();
    } else if (onboarding) {
      initialRoute = LoginPageScreen();
    } else {
      initialRoute = OnBoardingView();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
