import 'package:etaxi_admin/models/vehicle_model.dart';
import 'package:etaxi_admin/providers/order_provider.dart';
import 'package:etaxi_admin/services/main_service.dart';
import 'package:etaxi_admin/widgets/custom_button.dart';
import 'package:etaxi_admin/widgets/place_picker_widget.dart';
import 'package:etaxi_admin/widgets/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:provider/provider.dart';

import '../models/location_model.dart';

class OrderDialog extends StatefulWidget {
  const OrderDialog({super.key});

  @override
  State<OrderDialog> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sad za sad nista'),
      content: Column(
        children: [
          Consumer<OrderProvider>(
            builder: (context, notifier, child) => SearchBar(
                hintText:
                    notifier.currentLocationData?.address ?? 'Pocetna lokacija',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => PlacePickerWidget(
                                onPicked: (pickedData) {
                                  OrderProvider.instance.setCurrentLoc(
                                      Location.fromPickedData(pickedData));
                                  Navigator.pop(context);
                                },
                              ))));
                }),
          ),
          SizedBox(
            height: 16,
          ),
          Consumer<OrderProvider>(
            builder: (context, notifier, child) => SearchBar(
                hintText: notifier.destinationLocationData?.address ??
                    'Finalna lokacija',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => PlacePickerWidget(
                                onPicked: (pickedData) {
                                  OrderProvider.instance.setDestinationLoc(
                                      Location.fromPickedData(pickedData));
                                  Navigator.pop(context);
                                },
                              ))));
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Izaberite vozilo'),
          FutureBuilder<List<VehicleModel>>(
            future: MainServices.getVehicles(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No data available');
              } else {
                return DropdownButtonFormField(
                  items: snapshot.data!.map((VehicleModel item) {
                    return DropdownMenuItem(
                      value: item.vehicleId.toString(),
                      child: Text(item.vehicleName ?? 'Yugo 55'),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                );
              }
            },
          ),
          SizedBox(
            height: 16,
          ),
          Text('Izaberite sofera'),
          FutureBuilder<List<String>>(
            future: Future(() => ['aa', 'bb']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No data available');
              } else {
                return DropdownButtonFormField(
                  value: 'aa',
                  items: snapshot.data!.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                );
              }
            },
          ),
          Spacer(),
          CustomButton(
            label: 'Naruci voznju',
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    OrderProvider.instance.resetToInit();
    super.dispose();
  }
}
