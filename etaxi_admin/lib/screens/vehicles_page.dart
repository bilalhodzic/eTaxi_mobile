import 'package:etaxi_admin/utils/sizeConfig.dart';
import 'package:etaxi_admin/widgets/vehicleType_dialog.dart';
import 'package:etaxi_admin/widgets/vehicle_dialog.dart';
import 'package:flutter/material.dart';

class VehiclesPage extends StatelessWidget {
  const VehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => VehicleTypeDialog());
              },
              icon: Icon(Icons.add)),
          Text('Dodaj novi tip vozila')
        ],
      ),
      Row(
        children: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context, builder: (context) => VehicleDialog());
              },
              icon: Icon(Icons.add)),
          Text('Dodaj novo vozilo')
        ],
      ),
      sh(20),
      Text('Pregled svih vozila')
    ]);
  }
}
