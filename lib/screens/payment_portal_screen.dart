import 'package:flutter/material.dart';

class PaymentPortalScreen extends StatefulWidget {
  final String? qrcodeValue;

  const PaymentPortalScreen({Key? key, this.qrcodeValue}) : super(key: key);

  @override
  State<PaymentPortalScreen> createState() => _PaymentPortalScreenState();
}

class _PaymentPortalScreenState extends State<PaymentPortalScreen> {
  TextEditingController _paymentController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = extractNameFromQRCode(widget.qrcodeValue);
    _phoneNumberController.text =
        extractPhoneNumberFromQRCode(widget.qrcodeValue);
  }

  @override
  void dispose() {
    _paymentController.dispose();
    _phoneNumberController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Gateway'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Payment Page title
              Text(
                'Payment Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Scanned QR Code Value
              Text(
                'Scanned QR Code Value:',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                widget.qrcodeValue ?? 'No QR Code Value',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Name Text Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(height: 20),
              // Phone Number Text Field
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              // Payment value text field
              TextFormField(
                controller: _paymentController,
                decoration: InputDecoration(
                  labelText: 'Payment Amount',
                  hintText: 'Enter the payment amount',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the payment amount';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String extractNameFromQRCode(String? qrCodeValue) {
    return 'John Doe';
  }

  String extractPhoneNumberFromQRCode(String? qrCodeValue) {
    return '1234567890';
  }
}
