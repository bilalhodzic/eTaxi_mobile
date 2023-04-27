import 'dart:async';

import 'package:etaxi_mobile/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

GoogleMapController? mapController;

class GoogleMapWidget extends StatelessWidget {
  final CameraPosition cameraPosition;
  GoogleMapWidget({Key? key, required this.cameraPosition}) : super(key: key);

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, value, child) => GoogleMap(
        mapType: MapType.normal,
        compassEnabled: true,
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
        buildingsEnabled: false,
        markers: {
          if (value.currentLocation != null)
            Marker(
              markerId: MarkerId("pickup"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
              infoWindow: InfoWindow(title: "Preuzimanje"),
              position: LatLng(
                value.currentLocation!.latitude,
                value.currentLocation!.longitude,
              ),
            ),
          if (value.destinationLocation != null)
            Marker(
              markerId: MarkerId('destination'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue,
              ),
              infoWindow: InfoWindow(title: "Istovar"),
              position: LatLng(
                value.destinationLocation!.latitude,
                value.destinationLocation!.longitude,
              ),
            )
        },
        polylines: {
          if (value.directions != null)
            Polyline(
              polylineId: PolylineId('route'),
              color: Colors.black,
              width: 3,
              points: value.directions!.polylinePoints!
                  .map(
                    (e) => LatLng(e!.latitude, e.longitude),
                  )
                  .toList(),
            )
        },
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          mapController = controller;
        },
      ),
    );
  }
}
