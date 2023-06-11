import 'package:etaxi_admin/widgets/map_widget.dart';
import 'package:etaxi_admin/widgets/order_dialog.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Orders page'),
      Row(
        children: [
          IconButton(onPressed: () {
            showDialog(context: context, builder: (context)=> OrderDialog()
              
            );
          }, icon: Icon(Icons.add)),
          Text('Kreiraj novu narudzbu')
        ],
      ),
      MapWidget()
    ]);
  }


}
