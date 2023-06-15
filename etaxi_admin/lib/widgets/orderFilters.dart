import 'package:etaxi_admin/providers/order_provider.dart';
import 'package:etaxi_admin/utils/sizeConfig.dart';
import 'package:etaxi_admin/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class OrderFilters extends StatefulWidget {
  OrderFilters({Key? key, Function()? onSubmit}) : super(key: key);

  @override
  State<OrderFilters> createState() => _OrderFiltersState();
}

class _OrderFiltersState extends State<OrderFilters> {
  void Function()? onSubmit;

  String? selectedPaymentMethod;
  bool? isActive;
  bool? isCanceled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 500,
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            items: [
              DropdownMenuItem(
                child: Text('Aktivna'),
                value: 'active',
              ),
              DropdownMenuItem(
                child: Text('Zavrsena'),
                value: 'notActive',
              ),
              DropdownMenuItem(
                child: Text('Otkazana'),
                value: 'canceled',
              ),
            ],
            decoration: InputDecoration(
              labelText: 'Status narudzbe',
            ),
            onChanged: (value) {
              setState(() {
                switch (value) {
                  case 'active':
                    isActive = true;
                    isCanceled = null;
                    break;
                  case 'notActive':
                    isActive = false;
                    isCanceled = null;
                    break;
                  case 'canceled':
                    isCanceled = true;
                    isActive = null;
                    break;
                  default:
                }
              });
            },
          ),
          DropdownButtonFormField<String>(
            value: selectedPaymentMethod,
            items: [
              DropdownMenuItem(
                child: Text('Gotovina'),
                value: 'Gotovina',
              ),
              DropdownMenuItem(
                child: Text('Online'),
                value: 'Online',
              ),
            ],
            decoration: InputDecoration(
              labelText: 'Nacin placanja',
            ),
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value!;
              });
            },
          ),
          sh(10),
          CustomButton(
              label: "Primjeni",
              onPressed: () {
                Map<String, dynamic> filters = {};

                if (isActive != null) filters['IsActive'] = isActive.toString();
                if (isCanceled != null)
                  filters['IsCanceled'] = isCanceled.toString();
                if (selectedPaymentMethod != null)
                  filters['PaymentMethod'] = selectedPaymentMethod;

                OrderProvider.instance.setOrderFilters(filters);
              })
        ],
      ),
    );
  }
}
