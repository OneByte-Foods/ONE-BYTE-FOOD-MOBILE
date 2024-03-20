import 'package:flutter/material.dart';
import 'package:new_mobile_app/widgets/one_bytes_wigdet.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 60),
          child: buildLogo(),
        ),
        Container(
          margin: EdgeInsets.only(right: 150),
          child: const Text(
            'Login',
            style: TextStyle(
              fontSize: 35,
              fontFamily: 'MadimiOne',
            ),
          ),
        )
      ],
    ));
  }
}
