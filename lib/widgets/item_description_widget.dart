import 'package:One_Bytes_Food/widgets/textFrave.dart';
import 'package:flutter/material.dart';

class ItemsDescription extends StatelessWidget {
  const ItemsDescription({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 10),
          _buildSeatStatusWidget('Booking', Colors.white, Colors.white),
          SizedBox(width: 10),
          _buildSeatStatusWidget('Availabile', Colors.white54, Colors.white),
        ],
      ),
    );
  }

  Widget _buildSeatStatusWidget(String text, Color iconColor, Color textColor) {
    return Row(
      children: [
        Icon(Icons.circle, color: iconColor, size: 10),
        SizedBox(width: 10.0),
        TextFrave(text: text, fontSize: 10, color: textColor),
      ],
    );
  }
}
