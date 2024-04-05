// Provider Class
import 'package:flutter/material.dart';

class SeatReservationProvider extends ChangeNotifier {
  String _nameMovie = '';
  String _imageMovie = '';
  String _date = '0';
  String _time = '00';
  List<String> _selectedSeats = [];

  // Getters
  String get nameMovie => _nameMovie;
  String get imageMovie => _imageMovie;
  String get date => _date;
  String get time => _time;
  List<String> get selectedSeats => _selectedSeats;

  // Setters
  void updateSelectedMovie(String name, String image) {
    _nameMovie = name;
    _imageMovie = image;
    notifyListeners();
  }

  void updateSelectedDate(String date) {
    _date = date;
    notifyListeners();
  }

  void updateSelectedTime(String time) {
    _time = time;
    notifyListeners();
  }

  void updateSelectedSeats(String selectedSeats) {
    if (_selectedSeats.contains(selectedSeats)) {
      _selectedSeats.remove(selectedSeats);
    } else {
      _selectedSeats.add(selectedSeats);
    }
    notifyListeners();
  }
}
