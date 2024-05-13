import 'package:flutter/material.dart';

class SwipeAbleRemove extends StatelessWidget {
  final Map<String, dynamic> cObj;
  final Function(int) removeFromCart;
  final int index;

  SwipeAbleRemove(
      {required this.cObj, required this.removeFromCart, required this.index});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        removeFromCart(index);
      },
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
      ),
      direction: DismissDirection.endToStart,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              "${cObj["name"].toString()} x${cObj["qty"].toString()}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 15),
          Text(
            "\$${cObj["price"].toString()}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          IconButton(
            onPressed: () {
              removeFromCart(index);
            },
            icon: Icon(Icons.remove_rounded),
          ),
        ],
      ),
    );
  }
}
