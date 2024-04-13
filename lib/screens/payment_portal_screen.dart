import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

import '../constants/global_colors.dart';
import '../provider/qr_code_provider.dart';
import '../services/esewa_service.dart';
import '../widgets/build_btn.dart';
import '../widgets/circle_avatar_widget.dart';

class PaymentPortalScreen extends StatefulWidget {
  final String? qrcodeValue;

  const PaymentPortalScreen({Key? key, this.qrcodeValue}) : super(key: key);

  @override
  State<PaymentPortalScreen> createState() => _PaymentPortalScreenState();
}

class _PaymentPortalScreenState extends State<PaymentPortalScreen> {
  TextEditingController _paymentController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _remarksController = TextEditingController();
  String? _selectedPurpose;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Moved context-dependent logic to didChangeDependencies to ensure availability of context
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final provider = Provider.of<QrCodeProvider>(context, listen: false);
      var qrCodeValueObj = provider.getQrCodeObject();
      if (qrCodeValueObj != null) {
        String? khaltiID = qrCodeValueObj['Khalti_ID'];

        _phoneNumberController.text = khaltiID ?? "";
      }
    });
  }

  @override
  void dispose() {
    _paymentController.dispose();
    _phoneNumberController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildKhaltiPaymentPortal(Map<String, dynamic> qrCodeValueObj) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Added Form widget and assigned GlobalKey
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'Send From Khalti Account',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.khaltiColor),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              SizedBox(height: 20),
              _buildTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Khalti mobile number';
                  }
                  return null; // Added to handle valid case
                },
                controller: _phoneNumberController,
                labelText: 'Khalti Mobile Number',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              _buildTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Payment amount';
                  }
                  return null; // Added to handle valid case
                },
                controller: _paymentController,
                labelText: 'Amount',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              _buildPurposeDropdownFormField(),
              SizedBox(height: 20),
              _buildTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Remarks';
                  }
                  return null; // Added to handle valid case
                },
                controller: _remarksController,
                labelText: 'Remarks',
              ),
              SizedBox(height: 70),
              buildButton(
                context,
                text: "Proceed",
                color: AppColors.khaltiColor,
                borederRadius: BorderRadius.circular(5),
                width: MediaQuery.of(context).size.width * 0.8,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Added check for form validation
                    _payWithKhaltiInApp(
                      context,
                      amount: int.parse(_paymentController.text) * 100,
                      mobileNum: _phoneNumberController.text,
                    );
                  }
                },
              )
            ],
          ),
        ),
      );
    }

    Widget buildPaymentPortal() {
      final provider = Provider.of<QrCodeProvider>(context, listen: false);
      var qrCodeValueObj = provider.getQrCodeObject();

      if (qrCodeValueObj != null && qrCodeValueObj.containsKey("Khalti_ID")) {
        return buildKhaltiPaymentPortal(qrCodeValueObj);
      } else if (qrCodeValueObj != null &&
          qrCodeValueObj.containsKey("eSewa_id")) {
        Esewa esewa = Esewa();
        return esewa.pay();
      } else {
        return Container();
      }
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        actions: [
          buildCircleAvatar(radius: 20),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: buildPaymentPortal(),
    );
  }

  _buildPurposeDropdownFormField() {
    List<String> purposeOptions = [
      'Product Purchase',
      'Service Payment',
      'Membership Fee',
      'Donation',
      'Subscription',
      'Loan Repayment',
      'Bill Payment',
      'Event Registration',
      'Travel Expenses',
      'Gift Purchase',
    ];

    return DropdownButtonFormField<String>(
      value: _selectedPurpose,
      onChanged: (String? newValue) {
        setState(() {
          _selectedPurpose = newValue!;
        });
      },
      items: purposeOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Purpose',
        labelStyle: TextStyle(color: AppColors.khaltiColor),
        hintText: 'Select Purpose',
        hintStyle: TextStyle(color: AppColors.khaltiColor),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: Colors.black, fontSize: 16.0),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.khaltiColor),
        hintText: 'Enter $labelText',
        hintStyle: TextStyle(color: AppColors.khaltiColor),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      ),
    );
  }
}

void _payWithKhaltiInApp(context,
    {required int amount, required String mobileNum}) {
  KhaltiScope.of(context).pay(
    config: PaymentConfig(
      amount: amount,
      productIdentity: 'Product Id',
      productName: 'Product Name',
      mobileReadOnly: false,
      mobile: mobileNum,
    ),
    preferences: [
      PaymentPreference.khalti,
      PaymentPreference.connectIPS,
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
