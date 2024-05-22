import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/dependency_injection.dart';
import 'package:One_Bytes_Food/firebase_options.dart';
import 'package:One_Bytes_Food/onboarding/onboarding_view.dart';
import 'package:One_Bytes_Food/provider/cart_provider.dart';
import 'package:One_Bytes_Food/provider/location_provider.dart';
import 'package:One_Bytes_Food/provider/qr_code_provider.dart';
import 'package:One_Bytes_Food/provider/seat_provider.dart';
import 'package:One_Bytes_Food/routes/app_routes.dart';
import 'package:One_Bytes_Food/screens/dashboard_screen.dart';
import 'package:One_Bytes_Food/screens/login_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
      defaultColor: Color(0xFF9D50DD),
      ledColor: Colors.white,
    )
  ], channelGroups: [
    NotificationChannelGroup(
      channelGroupKey: "basic_channel_group",
      channelGroupName: "Basic Group",
    )
  ]);

  bool awesomeNotifications =
      await AwesomeNotifications().isNotificationAllowed();

  if (!awesomeNotifications) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding') ?? false;
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LocationProvider()),
      ChangeNotifierProvider(create: (context) => QrCodeProvider()),
      ChangeNotifierProvider(create: (context) => CartModel()),
      ChangeNotifierProvider(
        create: (context) => SeatProvider(),
      )
    ],
    child: MyApp(
      onboarding: onboarding,
      isLoggedIn: isLoggedIn,
    ),
  ));

  // check network connection
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  final bool isLoggedIn;

  const MyApp({
    Key? key,
    required this.onboarding,
    required this.isLoggedIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget initialRoute;
    if (isLoggedIn) {
      initialRoute = DashboardScreen();
    } else if (onboarding) {
      initialRoute = LoginPageScreen();
    } else {
      initialRoute = OnBoardingView();
    }
    return KhaltiScope(
      publicKey: "test_public_key_36942feb1dbd4caa9a724433cdf0254f",
      enabledDebugging: true,
      builder: (context, navKey) {
        return GetMaterialApp(
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ne', 'NP'),
          ],
          debugShowCheckedModeBanner: false,
          title: 'One Bytes Food',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.green,
              elevation: 0,
            ),
            colorSchemeSeed: Colors.deepPurple,
            useMaterial3: true,
          ),
          home: initialRoute,
          navigatorKey: navKey,
          routes: AppRoutes.routes,
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultMaterialLocalizations.delegate
          ],
        );
      },
    );
  }
}
