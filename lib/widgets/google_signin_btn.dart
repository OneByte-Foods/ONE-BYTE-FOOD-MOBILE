import 'package:flutter/material.dart';
import 'package:new_mobile_app/constants/global_colors.dart';
import 'package:new_mobile_app/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget buildGoogleSignInButton(BuildContext context, String text) {
  return Container(
    height: 50,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: AppColors.white,
    ),
    child: ElevatedButton(
      onPressed: () async {
        await setLoggedInStatus(true);
        AuthMethods().signInWithGoogle(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.pitchColor,
        backgroundColor: Color(0xffF4F4F4),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/icons/google_icon.png',
              scale: 20,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> setLoggedInStatus(bool isLoggedIn) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}
