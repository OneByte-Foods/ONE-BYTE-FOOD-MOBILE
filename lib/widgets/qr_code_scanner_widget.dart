// ignore_for_file: deprecated_member_use

import 'package:One_Bytes_Food/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/qr_code_provider.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Stack(
          children: [
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/khalti_logo.png",
                            width: 100,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Scan QR Code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Place the QR code inside the frame to scan",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                child: MobileScanner(
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.noDuplicates,
                    returnImage: true,
                  ),
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    final Uint8List? image = capture.image;
                    if (barcodes.isNotEmpty) {
                      final String barcodeValue = barcodes.first.rawValue ?? "";
                      final provider =
                          Provider.of<QrCodeProvider>(context, listen: false);
                      provider.setQrCodeValue(barcodeValue);
                      if (Uri.tryParse(barcodeValue)?.isAbsolute ?? false) {
                        _launchURL(barcodeValue);
                      } else {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.paymentPortalScreen,
                        );
                      }
                    }
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 350,
                height: 350,
                child: QRScannerOverlay(
                  borderColor: Colors.greenAccent,
                  overlayColor: Colors.white.withOpacity(0.5),
                  scanAreaHeight: 300,
                  scanAreaWidth: 300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
