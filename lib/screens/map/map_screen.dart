import 'dart:math';
import 'dart:ui';

import 'package:One_Bytes_Food/constants/user_constants.dart';
import 'package:One_Bytes_Food/utils/location_utility.dart';
import 'package:One_Bytes_Food/widgets/circle_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_style.dart';
import '../../constants/global_colors.dart';

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

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    isDriverCoordinatesAvailable = true;

    _customerLatLng = LatLng(
      double.parse(
        '27.6888212'.trim(),
      ),
      double.parse(
        '85.3450481'.trim(),
      ),
    );
    final cAddress = await LocationUtility.getAddress(
      double.parse("${_customerLatLng.latitude}"),
      double.parse("${_customerLatLng.longitude}"),
    );
    customerAddress = cAddress;

    _driverLatLng = LatLng(
      double.parse(
        '27.7018658'.trim(),
      ),
      double.parse(
        '85.3363784'.trim(),
      ),
    );
    final dAddress = await LocationUtility.getAddress(
      double.parse("${_driverLatLng.latitude}"),
      double.parse("${_driverLatLng.longitude}"),
    );
    driverAddress = dAddress;
    print("driverLatLng---> $_driverLatLng");
    // }
    final Uint8List driverIcon =
        await convertAssetToUnit8List("assets/icons/driver.png", width: 300);

    final Uint8List customerIcon = await convertAssetToUnit8List(
      "assets/icons/customer.png",
    );

    // Set markers for driver and customer
    _setMarker(
      _driverLatLng,
      'Driver',
      BitmapDescriptor.fromBytes(
        driverIcon,
      ),
    );
    _setMarker(
        _customerLatLng,
        'Customer',
        BitmapDescriptor.fromBytes(
          customerIcon,
        ));

    // Adjust camera position to fit both driver and customer locations
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

    // Draw polyline between driver and customer
    _drawPolyline(_driverLatLng, _customerLatLng);
  }

  void _setMarker(LatLng position, String markerId, BitmapDescriptor icon) {
    _markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: position,
        icon: icon,
      ),
    );
  }

  void _drawPolyline(LatLng origin, LatLng destination) async {
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyBqL3DrqJOHS-r_Fyxn0b-mGYeAD2oaRFE",
        PointLatLng(origin.latitude, origin.longitude),
        PointLatLng(destination.latitude,
            destination.longitude), // Destination coordinates
        travelMode: TravelMode.driving, // Travel mode
      );

      List<LatLng> polylineCoordinates = [];
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });

        // Create polyline options
        Polyline polyline = Polyline(
          polylineId: const PolylineId('route'),
          points: polylineCoordinates,
          color: Theme.of(context).primaryColor,
          width: 3,
        );

        // Add polyline to polylines set
        setState(() {
          _polylines.add(polyline);
        });
      } else {
        print("No polyline points found");
      }
    } catch (e) {
      print("Error drawing polyline: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Stack(children: [
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
                      InkWell(
                          onTap: () {
                            _mapController!.animateCamera(
                              CameraUpdate.newLatLngZoom(_driverLatLng, 17),
                            );
                          },
                          child: Icon(Icons.abc)),
                      SizedBox(height: 10),
                      InkWell(
                          onTap: () {
                            _mapController!.animateCamera(
                              CameraUpdate.newLatLngZoom(_customerLatLng, 17),
                            );
                          },
                          child: Icon(Icons.read_more)),
                      SizedBox(height: 10),
                      customerinformation(
                          name: "Kushal Chaulagain",
                          profileImage: UserConstants.userImageUrl,
                          phoneNumber: "9849816262"),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
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
      {int width = 50}) async {
    ByteData data = await rootBundle.load(imagePath);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
