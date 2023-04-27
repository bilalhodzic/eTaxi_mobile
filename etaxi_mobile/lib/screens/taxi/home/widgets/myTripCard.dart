import 'package:etaxi_mobile/utils/colors.dart';
import 'package:etaxi_mobile/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class MyTripCard extends StatelessWidget {
  MyTripCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15, bottom: 10, left: 15),
      decoration: BoxDecoration(
        boxShadow: boxShadow2,
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
              Padding(
                padding: EdgeInsets.only(top: 13, left: 20),
                child: Container(
                  height: 60,
                  width: 60,
                ),
              ),
              sb(10),
              Padding(
                padding: EdgeInsets.only(top: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ime musterije',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sh(3),
                    Text(
                      "Broj musrterije",
                      style: TextStyle(
                        color: Color(0xffa7a7a7),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              //PROMJENITI OVO KADA SE SPOJI SA BEKENDOM
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                decoration: BoxDecoration(
                  color: tagColor('CompletedLabel'),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Text(
                  'CompletedLabel',
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
                            "assets/icons/distance.svg",
                            width: 10,
                            color: Colors.black,
                          ),
                          sb(8),
                          Text(
                            'KILOMETARA' + " KM",
                            style: TextStyle(
                              fontSize: 10,
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
                          SvgPicture.asset(
                            "assets/icons/clock.svg",
                            width: 12,
                            color: Colors.black,
                          ),
                          sb(8),
                          Text(
                            DateFormat('dd.MM.yyyy').format(DateTime.now()),
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
                            'placanje',
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
                            'oklena je posao',
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
                            "adresa na koju je dosao",
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
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Text(
                    "Ma ja " + " Fare",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "TOTAL FARE",
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 0.6,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    sh(2),
                    Text(
                      "\$" + 'ukupan trosak',
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
  if (type == 'CancelledLabel')
    return Color(0xffc22a23);
  else if (type == 'CompletedLabel')
    return Color(0xff14ce5e);
  else if (type == "Assigned")
    return Color(0xff55a3ff);
  else if (type == "Ongoing") return secondaryColor;
  return Color(0xff395185);
}
