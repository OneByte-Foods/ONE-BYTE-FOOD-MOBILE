import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  String _currentLocation = "Loading...";

  String get currentLocation => _currentLocation;

  Future<void> updateLocation() async {
    try {
      bool locationPermissionGranted = await _checkLocationPermission();
      if (!locationPermissionGranted) {
        _currentLocation = "Permission not granted";
        notifyListeners();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      _currentLocation =
          (placemarks.isNotEmpty ? placemarks[0].name : "Unknown")!;
      print("Location -> " + _currentLocation);
      notifyListeners();
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return false;
      }
    }
    return true;
  }
}
