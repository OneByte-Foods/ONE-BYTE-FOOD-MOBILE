import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final IconData prefixIconData;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.isPassword = false,
    required this.prefixIconData,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 60.0,
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
              labelText: widget.labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: Icon(widget.prefixIconData),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        Icons.visibility,
                        size: 20,
                      ),
                      onPressed: () {},
                    )
                  : widget.controller.text.isEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 20,
                          ),
                          onPressed: () {
                            widget.controller.clear();
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
            validator: widget.validator,
          ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
