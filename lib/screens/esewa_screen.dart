import 'package:flutter/material.dart';

import '../services/esewa_service.dart';

class EsewaScreen extends StatelessWidget {
  const EsewaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Pay with E-Sewa'),
          onPressed: () {
            Esewa esewa = Esewa();
            esewa.pay();
          },
        ),
      ),
    );
  }
}
