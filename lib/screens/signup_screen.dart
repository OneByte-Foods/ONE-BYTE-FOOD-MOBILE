import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_mobile_app/constants/global_colors.dart';
import 'package:new_mobile_app/routes/app_routes.dart';
import 'package:new_mobile_app/widgets/build_btn.dart';
import 'package:new_mobile_app/widgets/custom_textField_widget.dart';
import 'package:new_mobile_app/widgets/google_signin_btn.dart';
import 'package:new_mobile_app/widgets/one_bytes_wigdet.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _registration() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Registration successful',
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        Navigator.pushNamed(context, AppRoutes.homePageScreen);
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred';
        if (e.code == 'weak-password') {
          errorMessage = 'Password provided is too weak';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Email address is already in use';
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
              'An unexpected error occurred',
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildLogo(),
                    CustomTextFormField(
                      controller: _emailController,
                      labelText: "Email address",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _passwordController,
                      labelText: "Password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        return null;
                      },
                      isPassword: true,
                    ),
                    SizedBox(height: 20),
                    buildButton(context,
                        text: "Registration",
                        color: AppColors.green,
                        onPressed: _registration),
                    SizedBox(height: 20),
                    buildGoogleSignInButton(context, "Sign up with Google"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
