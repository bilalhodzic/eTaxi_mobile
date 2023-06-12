import 'package:etaxi_admin/models/order_model.dart';
import 'package:etaxi_admin/utils/colors.dart';
import 'package:etaxi_admin/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class MyTripCard extends StatelessWidget {
  Order order;
  MyTripCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 350,
      margin: EdgeInsets.only(right: 15, bottom: 10, left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Padding(
              //   padding: EdgeInsets.only(top: 13, left: 20),
              //   child: Container(
              //     height: 60,
              //     width: 60,
              //   ),
              // ),
              sb(10),
              Padding(
                padding: EdgeInsets.only(top: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Korisnik: " +
                          (order.user?.firstName ?? '') +
                          ' ' +
                          (order.user?.lastName ?? ''),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sh(3),
                  ],
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                decoration: BoxDecoration(
                  color: tagColor(generateOrderStatus(order)),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Text(
                  generateOrderStatus(order),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          sh(12),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            color: primaryColor,
            height: 1.5,
            width: SizeConfig.screenWidth,
          ),
          sh(12),
          Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/calendar.svg",
                            width: 10,
                            color: Colors.black,
                          ),
                          sb(8),
                          Text(
                            'DATUM',
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/cash.svg",
                            width: 12,
                            color: Colors.black,
                          ),
                          sb(8),
                          Text(
                            "Nacin placanja",
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                sh(10),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Text(
                            DateFormat('dd.MM.yyyy').format(order.startTime!),
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Text(
                            order.paymentMethod ?? '',
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          sh(16),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                            order.startLocation?.address ?? '',
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
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/choose_city.svg',
                      color: Colors.red,
                      height: 20,
                    ),
                    sb(19),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.endLocation?.address ?? '',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          sh(16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            color: primaryColor,
            height: 1.5,
            width: SizeConfig.screenWidth,
          ),
          sh(12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 9,
                //     vertical: 5,
                //   ),
                //   decoration: BoxDecoration(
                //     color: primaryColor,
                //     borderRadius: BorderRadius.circular(11),
                //   ),
                //   child: Text(
                //     "Ma ja " + " Fare",
                //     style: TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.8),
                //     ),
                //   ),
                // ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "UKUPNO",
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 0.6,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    sh(2),
                    Text(
                      "${order.price} BAM",
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 0.6,
                        color: secondaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          sh(14),
        ],
      ),
    );
  }
}

Color tagColor(String type) {
  if (type == 'Otkazana')
    return Color(0xffc22a23);
  else if (type == 'Aktivna')
    return Color(0xff14ce5e);
  // else if (type == "Assigned")
  //   return Color(0xff55a3ff);
  else if (type == "Neaktivna") return secondaryColor;
  return Color(0xff395185);
}

String generateOrderStatus(Order order) {
  if (order.isCanceled == true) {
    return 'Otkazana';
  }
  if (order.isActive != true) {
    return "Neaktivna";
  } else
    return 'Aktivna';
}
