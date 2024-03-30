import 'package:One_Bytes_Food/firebase_options.dart';
import 'package:One_Bytes_Food/onboarding/onboarding_view.dart';
import 'package:One_Bytes_Food/routes/app_routes.dart';
import 'package:One_Bytes_Food/screens/home_screen.dart';
import 'package:One_Bytes_Food/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
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
      initialRoute = HomeScreen();
    } else if (onboarding) {
      initialRoute = LoginPageScreen();
    } else {
      initialRoute = OnBoardingView();
    }

    return KhaltiScope(
      publicKey: "test_public_key_36942feb1dbd4caa9a724433cdf0254f",
      enabledDebugging: true,
      builder: (context, navKey) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: initialRoute,
          navigatorKey: navKey,
          routes: AppRoutes.routes,
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
        );
      },
    );
  }
}
