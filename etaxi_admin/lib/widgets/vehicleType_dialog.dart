import 'package:flutter/material.dart';

class VehicleTypeDialog extends StatelessWidget {
  VehicleTypeDialog({super.key});

  TextEditingController type = TextEditingController();
  TextEditingController numberOfSeats = TextEditingController();
  TextEditingController imageUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Tip vozila'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Naziv tipa vozila',
              ),
              controller: type,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Slika tipa vozila (URL)',
              ),
              controller: imageUrl,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Broj sjedista',
              ),
              keyboardType: TextInputType.number,
              controller: numberOfSeats,
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
