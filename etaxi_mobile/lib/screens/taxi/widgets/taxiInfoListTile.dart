import 'package:etaxi_mobile/utils/colors.dart';
import 'package:etaxi_mobile/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class TaxiInfoListTile extends StatelessWidget {
  final EdgeInsets padding;
  const TaxiInfoListTile(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 4)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Color(0xff0000000).withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.red,
                width: 67,
                child: Center(child: Text("Slika taxia")),
              ),
              sb(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ime taxia',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Wrap(
                        runSpacing: 4,
                        spacing: 4,
                        children: [
                          Text('taxi features'),
                          Text('taxi features'),
                          Text('taxi features'),
                          Text('taxi features'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              sb(12),
              Text(
                'cijena BAM',
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
