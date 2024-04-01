import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../widgets/build_btn.dart';
import '../widgets/custom_textField_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String email = "";
  late TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void resetPassword() async {
    try {
      if (_formKey.currentState!.validate()) {
        email = _emailController.text;

        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Password Reset email has been sent to $email',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ));
        Navigator.pushNamed(context, AppRoutes.backEmailScreen);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'No user with email $email was found',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ));
      } else if (e.code == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Please enter a valid email address.',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ));
      }
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Enter your registered email below',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    prefixIconData: Icons.email,
                    controller: _emailController,
                    labelText: "Email address",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address.';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(text: 'Remember the password? '),
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(color: Colors.green),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacementNamed(
                                context, AppRoutes.signUpPage),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 400),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: buildButton(
                context,
                text: 'Submit',
                color: AppColors.green,
                onPressed: resetPassword,
              ),
            )
          ],
        ),
      ),
    );
  }
}
