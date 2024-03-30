import 'package:flutter/material.dart';

Widget buildButton(
  BuildContext context, {
  required String text,
  required Color color,
  Color textColor = Colors.white,
  required VoidCallback onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: color,
    ),
    width: MediaQuery.of(context).size.width * .7,
    height: 49,
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
        ),
      ),
    ),
  );
}
