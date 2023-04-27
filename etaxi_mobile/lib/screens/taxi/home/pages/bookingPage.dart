import 'package:etaxi_mobile/providers/order_provider.dart';
import 'package:etaxi_mobile/screens/taxi/widgets/taxiInfoListTile.dart';
import 'package:etaxi_mobile/utils/colors.dart';
import 'package:etaxi_mobile/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BookingPage extends StatelessWidget {
  BookingPage({Key? key}) : super(key: key);

  TextEditingController _promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              OrderProvider.instance.setBookingStage(BookingStage.DESTINATION);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 22,
                horizontal: 20,
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
              ),
            ),
          ),
          title: Text(
            "Izaberite vozilo",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Spacer(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              color: Colors.white,
              height: SizeConfig.screenHeight * 0.5,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      padding: EdgeInsets.fromLTRB(17, 20, 17, 20),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/blue_cirle.svg',
                                width: 17,
                              ),
                              sb(19),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      OrderProvider.instance.currentAddress ??
                                          "Trenutna lokacija",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Transform.translate(
                            offset: Offset(-3, 0),
                            child: Icon(
                              Icons.more_vert,
                              color: Color(0xff999999),
                            ),
                          ),
                          sh(5),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/choose_city.svg',
                                color: Color(0xffD40511),
                                height: 20,
                              ),
                              sb(19),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      OrderProvider
                                              .instance.destinationAddress ??
                                          "",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Izaberite svoj taxi",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    TaxiInfoListTile(),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 12),
                      child: Text(
                        "Promo kod",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _promoCodeController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 12),
                      child: Text(
                        "Nacin placanja",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 12),
                      child: Consumer<OrderProvider>(
                        builder: (context, notifier, child) => Row(
                          children: [
                            paymentMethodWidget(
                                'Online', notifier.paymentMethod == 'Online'),
                            sb(8),
                            paymentMethodWidget(
                                'Cash', notifier.paymentMethod == 'Cash')
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: MaterialButton(
                        height: 40,
                        minWidth: double.infinity,
                        color: Colors.black,
                        onPressed: () {
                          OrderProvider.instance
                              .setBookingStage(BookingStage.RIDE_BOOKED);
                        },
                        child: Text(
                          'Naruci voznju'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  Widget paymentMethodWidget(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        OrderProvider.instance.setPaymentMethod(text);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? primaryColor : Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ),
    );
  }
}
