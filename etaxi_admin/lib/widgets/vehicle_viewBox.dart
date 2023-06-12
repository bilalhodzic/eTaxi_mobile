import 'package:cached_network_image/cached_network_image.dart';
import 'package:etaxi_admin/models/vehicle_model.dart';
import 'package:etaxi_admin/services/main_service.dart';
import 'package:etaxi_admin/utils/colors.dart';
import 'package:etaxi_admin/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class VehicleBox extends StatelessWidget {
  VehicleBox({Key? key, required this.vehicle, this.fun}) : super(key: key);

  final VehicleModel vehicle;
  final MainServices services = MainServices();
  final Function()? fun;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(4), border: null),
      width: 200,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 67,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: vehicle.photo!,
                  height: 50,
                  width: 50,
                  fit: BoxFit.fitWidth,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            sb(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    vehicle.vehicleName!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  sh(5),
                  if (vehicle.companyName != '' && vehicle.companyName != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        vehicle.companyName ?? '',
                      ),
                    )
                ],
              ),
            ),
            sb(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${vehicle.price} BAM/km',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: primaryColor),
                ),
                sh(5),
                GestureDetector(
                  onTap: () {
                    // Perform delete operation
                    services.deleteVehicle(id: vehicle.vehicleId!);
                  },
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
