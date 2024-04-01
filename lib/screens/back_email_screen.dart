import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/routes/app_routes.dart';
import 'package:One_Bytes_Food/widgets/build_btn.dart';
import 'package:flutter/material.dart';

class BackEmailScreen extends StatelessWidget {
  const BackEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Image.asset(
                "assets/icons/sucess_icon.png",
                width: 150,
                height: 120,
              ),
            ),
            Text(
              "Success",
              style: TextStyle(
                fontSize: 24,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Please check your email to create \n a new password",
              style: TextStyle(
                color: Color(0xff6B7280),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: 'Can\'t get email? ',
                    style: TextStyle(color: Color(0xFF6B7280)),
                  ),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.forgotPasswordScreen),
                      child: Text(
                        'Resubmit',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 150),
            buildButton(context, text: "Done", color: AppColors.green,
                onPressed: () {
              AppRoutes.homePageScreen;
            })
          ],
        ),
      ),
    );
  }
}
