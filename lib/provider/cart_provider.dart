import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // List to store the items in the cart
  List<Map<String, dynamic>> _items = [];

  // Getter to access the items list
  List<Map<String, dynamic>> get items => _items;

  // Method to add an item to the cart
  void addToCart(Map<String, dynamic> item) {
    _items.add(item);
    notifyListeners(); // Notify listeners about the change
  }

  // Method to remove an item from the cart
  void removeFromCart(int index) {
    _items.removeAt(index);
    notifyListeners(); // Notify listeners about the change
  }

  double calculateSubTotal(List<Map<String, dynamic>> items) {
    double subTotal = 0.0;
    for (var item in items) {
      final price = item['price'] as num;
      final qty = item['qty'] as num;
      subTotal += price * qty;
    }
    return subTotal;
  }

  double calculateTotal(List<Map<String, dynamic>> items) {
    // Add delivery cost to the sub total
    return calculateSubTotal(items) + 2; // Assuming delivery cost is $2
  }
}
