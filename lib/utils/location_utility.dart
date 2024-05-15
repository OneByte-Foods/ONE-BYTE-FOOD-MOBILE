import 'package:One_Bytes_Food/provider/locationmodel.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationUtility {
  static getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      return '${place.subLocality}, ${place.locality}';
    } catch (e) {
      return 'Address not found';
    }
  }

  static Future<String> getCurrentAddress() async {
    LocationModel locationProvider = LocationModel();
    var currentAddress = await locationProvider.getUserAddress();

    return currentAddress;
  }

  static Future<void> openMap(
    double userLatitude,
    double userLongitude,
    double destinationLatitude,
    double destinationLongitude,
    String customerName,
  ) async {
    String googleUrl =
        '${"https://www.google.com/maps/dir/?api=1&origin="}$userLatitude,$userLongitude'
        '&destination=$destinationLatitude,$destinationLongitude&mode=d';
    await launchInBrowser(
      googleUrl,
    );
  }
}

Future<void> launchInBrowser(String url, [String? optionalUrl]) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
      Uri.parse(
        url,
      ),
      // mode: LaunchMode.platformDefault,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
        enableDomStorage: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      ),
    );
  } else {
    await launchUrl(
      Uri.parse(
        optionalUrl ?? url,
      ),
      // mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      ),
    );
  }
}

Future<void> launchUniversalLink(String url) async {
  if (await canLaunchUrl(
    Uri.parse(
      url,
    ),
  )) {
    await launchUrl(
      Uri.parse(url),
    );
  } else {}
}
