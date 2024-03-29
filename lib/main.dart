import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mobile_app/bloc/cinema/cinema_bloc.dart';
import 'package:new_mobile_app/firebase_options.dart';
import 'package:new_mobile_app/login/login_page.dart';
import 'package:new_mobile_app/onboarding/onboarding_view.dart';
import 'package:new_mobile_app/routes/app_routes.dart';
import 'package:new_mobile_app/seat%20reservation/screen/seat_reservation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
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
  const MyApp({Key? key, required this.onboarding, required this.isLoggedIn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget initialRoute;
    if (isLoggedIn) {
      initialRoute = BlocProvider<CinemaBloc>(
        create: (context) => CinemaBloc(),
        child: SeatReservationScreen(
          imageMovie: "assets/images/image.png",
          titleMovie: "Seat Reservation",
          key: key,
        ),
      );
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
