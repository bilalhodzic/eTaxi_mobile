import 'dart:developer';

import 'package:etaxi_admin/models/vehicle_type_model.dart';
import 'package:etaxi_admin/services/main_service.dart';
import 'package:etaxi_admin/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class VehicleDialog extends StatelessWidget {
  VehicleDialog({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController licenceNumber = TextEditingController();
  TextEditingController kmTraveled = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController imageUrl = TextEditingController();
  TextEditingController pricePerKm = TextEditingController();
  bool airBag = false;
  bool airCondition = false;

  //TextEditingController imageUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Dodaj novo vozilo'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Naziv',
              ),
              controller: name,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Slika vozila (URL)',
              ),
              controller: imageUrl,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Marka/Brand',
              ),
              controller: brand,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Godiste',
              ),
              keyboardType: TextInputType.number,
              controller: year,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Boja',
              ),
              controller: color,
            ),
            CheckboxListTile(
              value: airBag,
              onChanged: (value) {
                airBag = value!;
              },
              title: Text('AirBag'),
            ),
            CheckboxListTile(
              value: airCondition,
              onChanged: (value) {
                airCondition = value!;
              },
              title: Text('Klima'),
            ),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(
                  child: Text('Dizel'),
                  value: 'Dizel',
                ),
                DropdownMenuItem(
                  child: Text('Benzin'),
                  value: 'Benzin',
                ),
                DropdownMenuItem(
                  child: Text('Hibrid'),
                  value: 'Hibrid',
                ),
                DropdownMenuItem(
                  child: Text('Elektricno'),
                  value: 'Elektricno',
                ),
              ],
              decoration: InputDecoration(
                labelText: 'Tip goriva',
              ),
              onChanged: (value) {
                print(value);
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Cijena po kilometru',
              ),
              keyboardType: TextInputType.number,
              controller: pricePerKm,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Kilometraza',
              ),
              keyboardType: TextInputType.number,
              controller: kmTraveled,
            ),
            FutureBuilder<List<VehicleType>>(
                future: MainServices.getVehicleTypes(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  if (snapshot.hasData) {
                    return DropdownButtonFormField(
                        items: snapshot.data!
                            .map((VehicleType item) => DropdownMenuItem(
                                  child: Text(item.name!),
                                  value: item.id,
                                ))
                            .toList(),
                        decoration: InputDecoration(
                          labelText: 'Tip vozila',
                        ),
                        onChanged: (value) {
                          print(value);
                        });
                  }
                  return CircularProgressIndicator();
                })),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(
                  child: Text('Manual'),
                  value: 'Manual',
                ),
                DropdownMenuItem(
                  child: Text('Automatic'),
                  value: 'Automatic',
                ),
              ],
              decoration: InputDecoration(
                labelText: 'Transmisija',
              ),
              onChanged: (value) {
                print(value);
              },
            ),
          ]),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Odustani')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Dodaj'))
        ]);
  }
}
