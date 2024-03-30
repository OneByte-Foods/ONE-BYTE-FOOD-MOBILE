import 'package:flutter/material.dart';
import 'package:new_mobile_app/constants/global_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool isPassword;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: isPassword ? Icon(Icons.lock) : Icon(Icons.email),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    Icons.visibility,
                    size: 20,
                  ),
                  onPressed: () {},
                )
              : controller.text.isEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 20,
                      ),
                      onPressed: () {
                        controller.clear();
                      },
                    )
                  : null,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.green, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        style: TextStyle(fontSize: 16),
        validator: validator,
      ),
    );
  }
}
