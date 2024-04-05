import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/widgets/build_btn.dart';
import 'package:One_Bytes_Food/widgets/circle_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/qr_code_provider.dart';

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
    final provider = Provider.of<QrCodeProvider>(context, listen: false);
    var qrCodeValueObj = provider.getQrCodeObject();
    if (qrCodeValueObj != null) {
      String? khaltiID = qrCodeValueObj['Khalti_ID'];
      _phoneNumberController.text = khaltiID ?? "";
    }
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
            SizedBox(height: 20),
            _buildTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Khalti mobile number';
                }
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
              },
              controller: _remarksController,
              labelText: 'Remarks',
            ),
            SizedBox(height: 70),
            buildButton(context,
                text: "Procced",
                color: AppColors.khaltiColor,
                borederRadius: BorderRadius.circular(5),
                width: MediaQuery.of(context).size.width * 0.8, onPressed: () {
              if (_formKey.currentState!.validate()) {}
            })
          ],
        ),
      ),
    );
  }

  _buildPurposeDropdownFormField() {
    // List of predefined purpose options
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
