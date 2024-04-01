import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/routes/app_routes.dart';
import 'package:One_Bytes_Food/widgets/build_btn.dart';
import 'package:One_Bytes_Food/widgets/custom_textField_widget.dart';
import 'package:One_Bytes_Food/widgets/google_signin_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => LoginPageScreenState();
}

class LoginPageScreenState extends State<LoginPageScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    checkLoginStatus();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _navigateToForgotPassword() {
    Navigator.pushNamed(context, AppRoutes.forgotPasswordScreen);
  }

  void checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushNamed(context, AppRoutes.homePageScreen);
    }
  }

  userLogin() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      await setLoggedInStatus(true);
      Navigator.pushNamed(context, AppRoutes.homePageScreen);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.code == "user-not-found") {
        errorMessage = 'No user found for that email.';
      } else if (e.code == "wrong-password") {
        errorMessage = 'Wrong password provided for that user.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'An unexpected error occurred.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomTextFormField(
                      prefixIconData: Icons.email,
                      controller: emailController,
                      labelText: "Email address",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomTextFormField(
                      prefixIconData: Icons.lock,
                      controller: passwordController,
                      labelText: "Password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        return null;
                      },
                      isPassword: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 200),
                    child: TextButton(
                      onPressed: _navigateToForgotPassword,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.green,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        buildButton(
                            width: MediaQuery.of(context).size.width * .7,
                            context,
                            text: isLoading ? "" : "Login",
                            color: AppColors.green, onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            userLogin();
                          }
                        }),
                        if (isLoading)
                          Positioned(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Divider(color: AppColors.dividerColor),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GoogleSignInButton(text: "Login in with Google"),
            ),
          ],
        ),
      ),
    );
  }
}
