import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:etaxi_admin/models/vehicle_model.dart';
import 'package:etaxi_admin/models/vehicle_type_model.dart';
import 'package:etaxi_admin/services/main_service.dart';
import 'package:etaxi_admin/widgets/error_dialog.dart';
import 'package:flutter/material.dart';

class VehicleDialog extends StatefulWidget {
  VehicleDialog({Key? key, this.isEdit = false, this.vehicle})
      : super(key: key);
  bool isEdit = false;
  VehicleModel? vehicle;

  @override
  _VehicleDialogState createState() => _VehicleDialogState();
}

class _VehicleDialogState extends State<VehicleDialog> {
  //fields in dialog
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
  int? selectedVehicleType;
  int? selectedCompanyId;
  String? selectedFuelType;
  String? selectedTransmission;
//---
  MainServices mainServices = MainServices();

  @override
  void initState() {
    if (widget.vehicle != null) {
      name.text = widget.vehicle!.vehicleName!;
      licenceNumber.text = widget.vehicle!.licenceNumber!;
      kmTraveled.text = widget.vehicle!.kmTraveled.toString();
      year.text = widget.vehicle!.year.toString();
      color.text = widget.vehicle!.color!;
      brand.text = widget.vehicle!.brand!;
      imageUrl.text = widget.vehicle!.photo!;
      pricePerKm.text = widget.vehicle!.price.toString();
      airBag = widget.vehicle!.airBags!;
      airCondition = widget.vehicle!.airCondition!;
      selectedVehicleType = widget.vehicle!.type!.id;
      selectedCompanyId = widget.vehicle!.companyId ?? null;
      selectedFuelType = widget.vehicle!.fuelType;
      selectedTransmission = widget.vehicle!.transmission;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    inspect(widget.vehicle);
    return AlertDialog(
      title: Text(widget.isEdit ? "Izmjeni vozilo" : 'Dodaj novo vozilo'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                setState(() {
                  airBag = value!;
                });
              },
              title: Text('AirBag'),
            ),
            CheckboxListTile(
              value: airCondition,
              onChanged: (value) {
                setState(() {
                  airCondition = value!;
                });
              },
              title: Text('Klima'),
            ),
            DropdownButtonFormField<String>(
              value: selectedFuelType,
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
                setState(() {
                  selectedFuelType = value!;
                });
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
            TextField(
              decoration: InputDecoration(
                labelText: 'Broj registracije',
              ),
              keyboardType: TextInputType.number,
              controller: licenceNumber,
            ),
            FutureBuilder<List<VehicleType>>(
              future: MainServices.getVehicleTypes(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.hasData) {
                  return DropdownButtonFormField<int>(
                    value: selectedVehicleType,
                    items: snapshot.data!
                        .map(
                          (VehicleType item) => DropdownMenuItem<int>(
                            child: Text(item.name!),
                            value: item.id,
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Tip vozila',
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedVehicleType = value!;
                      });
                      print(value);
                    },
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            DropdownButtonFormField<String>(
              value: selectedTransmission,
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
                setState(() {
                  selectedTransmission = value!;
                });
                print(value);
              },
            ),
            FutureBuilder(
              future: MainServices.getCompanies(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.hasData) {
                  return DropdownButtonFormField<int>(
                    value: selectedCompanyId,
                    items: snapshot.data!
                        .map(
                          (item) => DropdownMenuItem<int>(
                            child: Text(item["name"]),
                            value: item["id"],
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Kompanija',
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedCompanyId = value!;
                      });
                      print(value);
                    },
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Odustani'),
        ),
        TextButton(
          onPressed: () {
            //Send data to server
            var data = {
              "name": name.text,
              "kmTraveled": kmTraveled.text,
              "licenceNumber": licenceNumber.text,
              "year": year.text,
              "airCondition": airCondition,
              "airBag": airBag,
              "fuelType": selectedFuelType!,
              "transmission": selectedTransmission!,
              "currentLocationId": 1,
              "color": color.text,
              "brand": brand.text,
              "pricePerKm": pricePerKm.text,
              "userDriverId": null,
              "typeId": selectedVehicleType!,
              "imageUrl": imageUrl.text,
              "companyId": selectedCompanyId,
            };
            print(jsonEncode(data));
            if (widget.isEdit) {
              data["id"] = widget.vehicle!.vehicleId;
            }
            try {
              if (widget.isEdit) {
                mainServices.editVehicle(
                    data: data, id: widget.vehicle!.vehicleId!);
              } else {
                mainServices.addVehicle(
                  data: data,
                );
              }
              Navigator.pop(context);
            } catch (e) {
              print('hereeeee in catch');
              print(e);
              showDialog(
                  context: context,
                  builder: (context) => ErrorDialog(
                        message: e.toString(),
                      ));
            }
          },
          child: Text(widget.isEdit ? "Izmjeni" : 'Dodaj'),
        ),
      ],
    );
  }
}
