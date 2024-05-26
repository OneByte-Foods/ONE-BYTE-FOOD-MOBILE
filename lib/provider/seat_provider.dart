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

  // Instance variables for current indices
  int _floorIndex = 0;
  int _tableIndex = 0;
  int _rowNumber = 0;
  int _seatNumber = 0;

  // Getter to access the selected seats for each table on each floor
  Map<int, Map<int, Map<int, Color>>> get floorTableSeatColors =>
      _floorTableSeatColors;

  // Getters for the indices
  int get floorIndex => _floorIndex;
  int get tableIndex => _tableIndex;
  int get rowNumber => _rowNumber;
  int get seatNumber => _seatNumber;

  // Method to update indices
  void setIndices(
      int floorIndex, int tableIndex, int rowNumber, int seatNumber) {
    _floorIndex = floorIndex;
    _tableIndex = tableIndex;
    _rowNumber = rowNumber;
    _seatNumber = seatNumber;
    notifyListeners();
  }

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
          'Floor: $floorIndex, Row: $rowNumber, Table: ${whichTable()}, Seat: $seatNumber booked');
    } else {
      // Seat is already booked, so unbook it
      _floorTableSeatColors[floorIndex]![tableIndex]!.remove(seatNumber);
      print(
          'Floor: $floorIndex, Row: $rowNumber, Table: ${whichTable()}, Seat: $seatNumber unbooked');
    }

    database
        .child('Bookings')
        .child('floorLevel$floorIndex')
        .child('users')
        .push()
        .set(
      {
        "tableType": whichTable(),
        "seatNumber": seatNumber - 10,
        'status': _floorTableSeatColors[floorIndex]![tableIndex]!
                .containsKey(seatNumber)
            ? 'booked'
            : 'unbooked',
        "userName": UserConstants.userNameUrl,
        "useProfilePic": UserConstants.userImageUrl,
        "userEmail": UserConstants.userEmail,
      },
    );

    notifyListeners();
  }
}
