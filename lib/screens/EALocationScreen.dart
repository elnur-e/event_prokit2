import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EALocationScreen extends StatefulWidget {
  const EALocationScreen({Key? key}) : super(key: key);

  @override
  _EALocationScreenState createState() => _EALocationScreenState();
}

class _EALocationScreenState extends State<EALocationScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        compassEnabled: true,
        zoomGesturesEnabled: true,
      ),
    );
  }
}
