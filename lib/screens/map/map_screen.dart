import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:One_Bytes_Food/controller/notification_controller.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_style.dart';
import '../../constants/global_colors.dart';
import '../../utils/location_utility.dart';
import '../../widgets/circle_avatar_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late LatLng _driverLatLng = LatLng(27.7278, 85.3782);
  late LatLng _customerLatLng = LatLng(27.7166, 85.3485);
  Set<Marker> markers = {};
  Set<Marker> get _markers => markers;
  PolylinePoints polylinePoints = PolylinePoints();
  String driverAddress = 'Loading...';
  String customerAddress = 'Loading...';
  Set<Polyline> polylines = {};
  Set<Polyline> get _polylines => polylines;

  GoogleMapController? _mapController;
  bool isDriverCoordinatesAvailable = false;
  List<LatLng> polylineCoordinates = [];
  late Timer _timer;
  int _currentPositionIndex = 0;

  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    dotenv.load(fileName: '.env');
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    isDriverCoordinatesAvailable = true;

    _customerLatLng = LatLng(
      double.parse('27.6888212'.trim()),
      double.parse('85.3450481'.trim()),
    );
    final cAddress = await LocationUtility.getAddress(
      double.parse("${_customerLatLng.latitude}"),
      double.parse("${_customerLatLng.longitude}"),
    );
    customerAddress = cAddress;

    _driverLatLng = LatLng(
      double.parse('27.7018658'.trim()),
      double.parse('85.3363784'.trim()),
    );
    final dAddress = await LocationUtility.getAddress(
      double.parse("${_driverLatLng.latitude}"),
      double.parse("${_driverLatLng.longitude}"),
    );
    driverAddress = dAddress;
    print("driverLatLng---> $_driverLatLng");

    final Uint8List driverIcon =
        await convertAssetToUnit8List("assets/icons/driver.png", width: 200);

    final Uint8List customerIcon = await convertAssetToUnit8List(
      "assets/icons/customer.png",
    );

    _setMarker(
      _driverLatLng,
      'Driver',
      BitmapDescriptor.fromBytes(driverIcon),
    );
    _setMarker(
      _customerLatLng,
      'Customer',
      BitmapDescriptor.fromBytes(customerIcon),
    );

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        min(_driverLatLng.latitude, _customerLatLng.latitude),
        min(_driverLatLng.longitude, _customerLatLng.longitude),
      ),
      northeast: LatLng(
        max(_driverLatLng.latitude, _customerLatLng.latitude),
        max(_driverLatLng.longitude, _customerLatLng.longitude),
      ),
    );

    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 100),
    );

    _drawPolyline(_driverLatLng, _customerLatLng);

    _startMovingMarker();
  }

  void _setMarker(LatLng position, String markerId, BitmapDescriptor icon) {
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
          icon: icon,
        ),
      );
    });
  }

  void _drawPolyline(LatLng origin, LatLng destination) async {
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "${dotenv.env["GOOGLE_MAP_API"]}",
        PointLatLng(origin.latitude, origin.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
        polylineCoordinates.clear();
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });

        Polyline polyline = Polyline(
          polylineId: const PolylineId('route'),
          points: polylineCoordinates,
          color: Theme.of(context).primaryColor,
          width: 3,
        );

        setState(() {
          polylines.add(polyline);
        });
      } else {
        print("No polyline points found");
      }
    } catch (e) {
      print("Error drawing polyline: $e");
    }
  }

  void _startMovingMarker() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      if (_currentPositionIndex < polylineCoordinates.length) {
        setState(() {
          markers.removeWhere((marker) => marker.markerId.value == 'Moving');
          markers.add(
            Marker(
              markerId: MarkerId('Moving'),
              position: polylineCoordinates[_currentPositionIndex],
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue,
              ),
            ),
          );
          _currentPositionIndex++;
        });
      } else {
        timer.cancel();
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 1,
                channelKey: "basic_channel",
                title: "Order Delivered",
                body: "Your order has been delivered successfully!"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                minMaxZoomPreference: const MinMaxZoomPreference(0, 20),
                initialCameraPosition: CameraPosition(
                  target: _driverLatLng,
                  zoom: 10,
                ),
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: true,
                zoomControlsEnabled: false,
                markers: _markers,
                polylines: _polylines,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                onCameraIdle: () {
                  print("Camera idle...");
                },
                onCameraMove: (position) {
                  print("Camera moving...");
                  _driverLatLng = position.target;
                },
                onCameraMoveStarted: () {
                  print("Camera moving...");
                },
              ),
              Positioned(
                left: 8.0,
                right: 15.0,
                bottom: 15.0,
                child: InkWell(
                  onTap: () {
                    if (_mapController != null) {
                      _mapController!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: _customerLatLng,
                            zoom: 17,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      color: Theme.of(context).canvasColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300]!,
                          spreadRadius: 3,
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                        customerinformation(
                          name: "Kushal Chaulagain",
                          profileImage: "assets/icons/driver.png",
                          phoneNumber: "9849816262",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  // ignore: deprecated_member_use
  await launch(launchUri.toString());
}

Widget customerinformation(
    {String? name, String? profileImage, String? phoneNumber}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColors.greySecondary,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.all(
      8,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Column(
              children: [
                buildCircleAvatar(radius: 20),
                Text(
                  name ?? 'Please wait...',
                  style: AppStyles.text12PxMedium,
                ),
                Text(
                  phoneNumber ?? 'Please wait...',
                  style: AppStyles.text12PxRegular,
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => _makePhoneCall("9849816262"),
              child: Icon(
                Icons.phone_enabled,
                size: 30,
              ),
            )
          ],
        )
      ],
    ),
  );
}

Future<Uint8List> convertAssetToUnit8List(String imagePath,
    {int width = 150}) async {
  ByteData data = await rootBundle.load(imagePath);
  var codec = await instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
