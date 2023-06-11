import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class PlacePickerWidget extends StatelessWidget {
  final Function(PickedData) onPicked;
  const PlacePickerWidget({super.key,required this.onPicked});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                body: FlutterLocationPicker(
                      initZoom: 14,
                      minZoomLevel: 11,
                      maxZoomLevel: 16,
                      initPosition: LatLong(43.8460522,18.3916678),
                      trackMyPosition: true,
                      selectLocationButtonText: 'Odaberi lokaciju',
                      onPicked:onPicked),
              );
  }
}