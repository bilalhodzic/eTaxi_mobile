import 'package:etaxi_mobile/screens/taxi/home/widgets/myTripCard.dart';
import 'package:etaxi_mobile/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class MyTripPage extends StatefulWidget {
  const MyTripPage({Key? key}) : super(key: key);

  @override
  State<MyTripPage> createState() => _MyTripPageState();
}

class _MyTripPageState extends State<MyTripPage> {
  List<String> types = [
    'AllBookingsLabel',
    'PendingLabel',
    'ConfirmedLabel',
    'OnGoingLabel',
    'CompletedLabel',
    'CancelledLabel',
  ];

  String historyType = 'AllBookingsLabel';

  List numbers = [1, 3, 2, 8, 5, 0, 4, 6, 7];

  String label(String title) {
    if (title == 'PendingLabel')
      return "assets/icons/pending.svg";
    else if (title == 'ConfirmedLabel')
      return "assets/icons/confirmed.svg";
    else if (title == 'CompletedLabel')
      return "assets/icons/completed.svg";
    else if (title == 'CancelledLabel')
      return "assets/icons/cancelled.svg";
    else if (title == 'ConfirmedLabel')
      return "assets/icons/confirmed.svg";
    else if (title == 'AllBookingsLabel')
      return "assets/icons/all bookings.svg";

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AppBar(
            centerTitle: true,
            elevation: 0,
            leadingWidth: 40,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: PopupMenuButton<String>(
                padding: EdgeInsets.only(left: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onSelected: (value) {
                  setState(() {
                    historyType = value;
                  });
                },
                itemBuilder: (BuildContext context) {
                  return types.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            choice != 'OnGoingLabel'
                                ? label(choice)
                                : "assets/icons/choose_your_car.svg",
                            width: 16,
                            color: Colors.black,
                          ),
                          sb(26),
                          Text(
                            choice,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.75),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList();
                },
                child: SvgPicture.asset(
                  "assets/icons/filter.svg",
                  color: Colors.black,
                  width: 20,
                ),
              ),
            ),
            title: Text(
              "Moja putovanja",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: SizeConfig.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sh(20),
                  Expanded(
                      child: ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    itemCount: 5,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(onTap: () {}, child: MyTripCard());
                    },
                  )),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
