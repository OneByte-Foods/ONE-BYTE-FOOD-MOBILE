import 'package:flutter/material.dart';

class SeatProvider extends ChangeNotifier {
  // Map to store selected seats for each table on each floor
  Map<int, Map<int, Map<int, Color>>> _floorTableSeatColors = {};

  // Getter to access the selected seats for each table on each floor
  Map<int, Map<int, Map<int, Color>>> get floorTableSeatColors =>
      _floorTableSeatColors;

  void toggleSeatColor(int floorIndex, int tableIndex, int seatNumber) {
    if (!_floorTableSeatColors.containsKey(floorIndex)) {
      _floorTableSeatColors[floorIndex] = {};
    }

    if (!_floorTableSeatColors[floorIndex]!.containsKey(tableIndex)) {
      _floorTableSeatColors[floorIndex]![tableIndex] = {};
    }

    if (_floorTableSeatColors[floorIndex]![tableIndex]!
        .containsKey(seatNumber)) {
      _floorTableSeatColors[floorIndex]![tableIndex]!.remove(seatNumber);
    } else {
      _floorTableSeatColors[floorIndex]![tableIndex]![seatNumber] = Colors.red;
    }
    notifyListeners();
  }
}
