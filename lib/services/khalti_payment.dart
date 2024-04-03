import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

payWithKhaltiInApp(BuildContext context) {
  KhaltiScope.of(context).pay(
    config: PaymentConfig(
      amount: 1000,
      productIdentity: 'Product Id',
      productName: 'Product Name',
      mobileReadOnly: false,
    ),
    preferences: [
      PaymentPreference.khalti,
    ],
    onSuccess: (success) => onSuccess(context, success),
    onFailure: onFailure,
    onCancel: onCancel,
  );
}

void onSuccess(BuildContext context, PaymentSuccessModel success) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Payment Successful'),
        actions: [
          SimpleDialogOption(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      );
    },
  );
}

void onFailure(PaymentFailureModel failure) {
  debugPrint(
    failure.toString(),
  );
}

void onCancel() {
  debugPrint('Cancelled');
}
