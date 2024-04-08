import 'package:flutter/material.dart';

class SeatProvider extends ChangeNotifier {
  Map<int, Map<int, Color>> _tableSeatColors = {};

  Map<int, Map<int, Color>> get tableSeatColors => _tableSeatColors;

  void toggleSeatColor(int tableIndex, int seatNumber) {
    if (!_tableSeatColors.containsKey(tableIndex)) {
      _tableSeatColors[tableIndex] = {};
    }

    if (_tableSeatColors[tableIndex]!.containsKey(seatNumber)) {
      _tableSeatColors[tableIndex]!.remove(seatNumber);
    } else {
      _tableSeatColors[tableIndex]![seatNumber] = Colors.red;
    }
    notifyListeners();
  }
}
