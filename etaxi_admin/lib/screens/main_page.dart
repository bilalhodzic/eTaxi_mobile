import 'package:date_time_picker/date_time_picker.dart';
import 'package:etaxi_admin/widgets/custom_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainPageAdmin extends StatelessWidget {
  MainPageAdmin({super.key});

  String? fromDate;
  String? toDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Od datuma:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DateTimePicker(
                        initialValue: '',
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Datum',
                        onChanged: (val) => fromDate = val,
                        validator: (val) {
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Do datuma:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DateTimePicker(
                        initialValue: '',
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Datum',
                        onChanged: (val) => toDate = val,
                        validator: (val) {
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 54,
                width: 120,
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.black,
                  child: Text(
                    'Primjeni',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _buildStatisticTile('Ukupan broj narudžbi', 69),
              _buildStatisticTile('Zarada', 69),
              _buildStatisticTile('Otkazane narudžbe', 69),
              _buildStatisticTile('Vožnje po korisniku', 69),
              _buildStatisticTile('Vožnje po vozaču', 69),
              _buildStatisticTile('Vožnje po vozilu', 69),
              _buildStatisticTile('Najkorištenija ruta taksi vozila', 'Ruta A'),
              _buildStatisticTile(
                  'Najprometniji dan i vrijeme', 'Ponedjeljak, 9 AM'),
              _buildStatisticTile(
                  'Zaposlenik sa najviše narudžbi', 'Petar Petrovic'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticTile(String title, dynamic value) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              value.toString(),
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
