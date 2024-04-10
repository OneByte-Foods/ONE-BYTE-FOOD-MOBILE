import 'package:One_Bytes_Food/constants/db_constants.dart';
import 'package:One_Bytes_Food/constants/user_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SeatProvider extends ChangeNotifier {
  final DatabaseReference database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: DbConstants.dbUrl,
  ).ref();

  // Map to store selected seats for each table on each floor
  Map<int, Map<int, Map<int, Color>>> _floorTableSeatColors = {};

  // Getter to access the selected seats for each table on each floor
  Map<int, Map<int, Map<int, Color>>> get floorTableSeatColors =>
      _floorTableSeatColors;

  void toggleSeat(
      int floorIndex, int tableIndex, int seatNumber, int rowNumber) {
    if (!_floorTableSeatColors.containsKey(floorIndex)) {
      _floorTableSeatColors[floorIndex] = {};
    }

    if (!_floorTableSeatColors[floorIndex]!.containsKey(tableIndex)) {
      _floorTableSeatColors[floorIndex]![tableIndex] = {};
    }

    String whichTable() {
      if (tableIndex == 1)
        return "The big Table";
      else if (tableIndex == 10)
        return "Bar Counter";
      else {
        return "Table $tableIndex";
      }
    }

    if (!_floorTableSeatColors[floorIndex]![tableIndex]!
        .containsKey(seatNumber)) {
      // Seat is not booked, so book it
      _floorTableSeatColors[floorIndex]![tableIndex]![seatNumber] =
          Colors.green;

      print(
          'Floor: $floorIndex, Row: $rowNumber, Table: ${whichTable()}, Seat: ${seatNumber} booked');
    } else {
      // Seat is already booked, so unbook it
      _floorTableSeatColors[floorIndex]![tableIndex]!.remove(seatNumber);
      print(
          'Floor: $floorIndex, Row: $rowNumber, Table: ${whichTable()}, Seat: ${seatNumber} unbooked');
    }
    database
        .child('Bookings')
        .child('floor$floorIndex')
        .child('${whichTable().toString()}')
        .child('seat${seatNumber - 10}')
        .update({
      "userName": UserConstants.userNameUrl.toString(),
      "useProfilePic": UserConstants.userImageUrl.toString(),
      'status': _floorTableSeatColors[floorIndex]![tableIndex]!
              .containsKey(seatNumber)
          ? 'booked'
          : 'unbooked',
    });

    notifyListeners();
  }
}
