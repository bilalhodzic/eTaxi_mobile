import 'package:etaxi_mobile/models/directions_model.dart';
import 'package:etaxi_mobile/providers/order_provider.dart';
import 'package:etaxi_mobile/services/directions_services.dart';
import 'package:etaxi_mobile/utils/sizeConfig.dart';
import 'package:etaxi_mobile/widgets/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:provider/provider.dart';

import '../../../../api/api_model.dart';

class PickupWidget extends StatelessWidget {
  const PickupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        height: SizeConfig.screenHeight * 0.2,
        child: Column(
          children: [
            sh(26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Consumer<OrderProvider>(
                builder: (context, value, child) => SearchBar(
                  hintText: value.destinationAddress != null
                      ? value.destinationAddress!
                      : "Izaberite krajnju lokaciju",
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    LocationResult result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlacePicker(googleApiKey),
                        ));

                    if (result.latLng != null) {
                      await OrderProvider.instance.setDestinationLoc(
                          result.latLng!, result.formattedAddress!);
                    }
                    Directions? dir = await DirectionServices().getDirections(
                        origin: OrderProvider.instance.currentLocation!,
                        dest: result.latLng!);

                    if (dir != null)
                      await OrderProvider.instance.setDirections(dir);
                  },
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: MaterialButton(
                height: 40,
                minWidth: double.infinity,
                color: Colors.black,
                onPressed: () {
                  if (OrderProvider.instance.destinationLocation == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Unesite odredisnu lokaciju')));
                  } else
                    OrderProvider.instance
                        .setBookingStage(BookingStage.DESTINATION);
                },
                child: Text(
                  'Nastavi'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}