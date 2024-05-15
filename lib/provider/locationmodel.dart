import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationModel with ChangeNotifier {
  Placemark _address = const Placemark();

  Placemark get address => _address;
  Position _currentLocation = Position(
    latitude: 0,
    longitude: 0,
    speed: 1,
    speedAccuracy: 1,
    altitude: 1,
    accuracy: 1,
    heading: 1,
    timestamp: DateTime.now(),
    altitudeAccuracy: 1,
    headingAccuracy: 1,
  );
  Position get currentLocation => _currentLocation;

  Future<Position> locateUser() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> getUserAddress() async {
    _currentLocation = await locateUser();
    List<Placemark> currentAddresses = await placemarkFromCoordinates(
      _currentLocation.latitude,
      _currentLocation.longitude,
    );
    _address = currentAddresses.first;
    String addressString = "${_address.street}, ${_address.locality}";
    notifyListeners();
    return addressString;
  }

  void getUserLocation() async {
    _currentLocation = await locateUser();
    var currentAddresses = await placemarkFromCoordinates(
        _currentLocation.latitude, _currentLocation.longitude);
    _address = currentAddresses.first;
    notifyListeners();
  }
}
