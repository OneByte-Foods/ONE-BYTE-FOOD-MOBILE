import 'package:flutter/material.dart';

class SeatModel extends ChangeNotifier {
  Map<int, Color> _seatColors = {};

  Map<int, Color> get seatColors => _seatColors;

  void toggleSeatColor(int seatNumber) {
    if (_seatColors.containsKey(seatNumber)) {
      _seatColors.remove(seatNumber);
    } else {
      _seatColors[seatNumber] = Colors.blue;
    }
    notifyListeners();
  }
}
