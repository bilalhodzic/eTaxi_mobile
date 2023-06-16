import 'package:etaxi_admin/providers/auth_provider.dart';
import 'package:etaxi_admin/services/main_service.dart';
import 'package:etaxi_admin/utils/sizeConfig.dart';
import 'package:etaxi_admin/widgets/vehicleType_dialog.dart';
import 'package:etaxi_admin/widgets/vehicle_dialog.dart';
import 'package:etaxi_admin/widgets/vehicle_viewBox.dart';
import 'package:flutter/material.dart';

class VehiclesPage extends StatelessWidget {
  const VehiclesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => VehicleTypeDialog(),
                );
              },
              icon: Icon(Icons.add),
            ),
            Text('Dodaj novi tip vozila'),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => VehicleDialog(),
                );
              },
              icon: Icon(Icons.add),
            ),
            Text('Dodaj novo vozilo'),
          ],
        ),
        sh(20),
        Text(
          'Pregled svih vozila',
          style: TextStyle(fontSize: 20),
        ),
        sh(16),
        Expanded(
          child: Container(
            width: 550,
            child: FutureBuilder(
              future: MainServices.getVehicles(queryParams: {
                "CompanyId":
                    AuthProvider.instance.user!.companyId?.toString() ?? null
              }),
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 5),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return VehicleBox(
                        vehicle: snapshot.data![index],
                      );
                    },
                  );
                }
                return CircularProgressIndicator();
              }),
            ),
          ),
        ),
      ],
    );
  }
}
