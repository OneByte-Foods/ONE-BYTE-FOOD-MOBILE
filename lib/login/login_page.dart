import 'package:flutter/material.dart';
import 'package:new_mobile_app/constants/app_style.dart';
import 'package:new_mobile_app/constants/global_colors.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  static const String routeName = '/login-page-screen';

  @override
  State<LoginPageScreen> createState() => LoginPageScreenState();
}

class LoginPageScreenState extends State<LoginPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildLogo(),
          _buildTitle(),
          Divider(color: AppColors.dividerColor),
          SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGoogleSignInButton(),
                SizedBox(height: 20),
                Text(
                  'or',
                  style: AppStyles.text14PxRegular.copyWith(fontSize: 14),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text('Continue with your email',
                        style: AppStyles.text14PxRegular.copyWith(
                            fontSize: 14,
                            decoration: TextDecoration.underline)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      child: Image.asset(
        'assets/images/one_bytes_icon.png',
        height: 250,
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      child: const Text(
        'Login',
        style: TextStyle(
          fontSize: 35,
          fontFamily: 'MadimiOne',
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton() {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.white,
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.pitchColor,
          backgroundColor: AppColors.white,
          elevation: 5,
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
                'Continue with Google',
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
}
