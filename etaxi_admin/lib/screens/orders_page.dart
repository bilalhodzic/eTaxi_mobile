import 'package:etaxi_admin/models/order_model.dart';
import 'package:etaxi_admin/services/order_service.dart';
import 'package:etaxi_admin/utils/sizeConfig.dart';
import 'package:etaxi_admin/widgets/my_trip_card.dart';
import 'package:etaxi_admin/widgets/order_dialog.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Orders page'),
        sh(16),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context, builder: (context) => OrderDialog());
                },
                icon: Icon(Icons.add)),
            Text('Kreiraj novu narudzbu')
          ],
        ),
        sh(16),
        SizedBox(
          width: SizeConfig.screenWidth * 0.7,
          child: FutureBuilder<List<Order>>(
              future: OrderService.getAllOrders(),
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Wrap(
                    children: List.generate(snapshot.data!.length,
                        (index) => MyTripCard(order: snapshot.data![index])),
                    clipBehavior: Clip.hardEdge,
                  );

                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ]),
    );
  }
}
