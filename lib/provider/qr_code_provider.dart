import 'dart:convert';

import 'package:flutter/material.dart';

class QrCodeProvider extends ChangeNotifier {
  String? _qrCodeValue;

  void setQrCodeValue(String value) {
    _qrCodeValue = value;
    notifyListeners();
  }

  Map<String, dynamic>? getQrCodeObject() {
    if (_qrCodeValue != null) {
      try {
        return json.decode(_qrCodeValue!);
      } catch (e) {
        print("Error decoding QR code value: $e");
      }
    }
    return null;
  }

  String? getQrCodeValue() {
    return _qrCodeValue;
  }
}
