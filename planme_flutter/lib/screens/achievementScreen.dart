import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/route.dart' show achievementRoute;
import 'package:planme_flutter/widgets/achievement/showStar.dart';
import 'package:planme_flutter/widgets/achievement/achievements.dart';
// import 'package:planme_flutter/widgets/achievement/allTab.dart';
// import 'package:planme_flutter/widgets/achievement/valentineTab.dart';

class AchievementScreen extends StatelessWidget {
  static final routeName = achievementRoute;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            ShowStar('300'),
            Text(
              'Achievements',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: titleColorBlack,
              ),
            ),
            Achievements()
            // Keep it as your memory or delete if you want and also allTab, valentineTab too.
            // ListView(
            //   children: <Widget>[
            //     Row(
            //       children: [
            //         Container(
            //           padding: EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 15.0),
            //           child: Text(
            //             'Christmas Collection',
            //             style: TextStyle(
            //               fontSize: 20.0,
            //               fontWeight: FontWeight.bold,
            //               color: titleColorBlack,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       mainAxisSize: MainAxisSize.max,
            //       children: [
            //         Expanded(
            //           child: Container(
            //               width: 200.0,
            //               height: 250.0,
            //               margin: EdgeInsets.fromLTRB(15.0, 2.0, 20.0, 15.0),
            //               padding: EdgeInsets.fromLTRB(15.0, 2.0, 20.0, 15.0),
            //               decoration: BoxDecoration(
            //                 color: appbarColor,
            //                 borderRadius: BorderRadius.all(
            //                   Radius.circular(18),
            //                 ),
            //               ),
            //               child: AllTab()),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Container(
            //           padding: EdgeInsets.fromLTRB(15.0, 8.0, 10.0, 15.0),
            //           child: Text(
            //             'Valentine Collection',
            //             style: TextStyle(
            //               fontSize: 20.0,
            //               fontWeight: FontWeight.bold,
            //               color: titleColorBlack,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       mainAxisSize: MainAxisSize.max,
            //       children: [
            //         Expanded(
            //           child: Container(
            //               width: 200.0,
            //               height: 250.0,
            //               margin: EdgeInsets.fromLTRB(15.0, 2.0, 20.0, 30.0),
            //               padding: EdgeInsets.fromLTRB(15.0, 2.0, 20.0, 15.0),
            //               decoration: BoxDecoration(
            //                 color: appbarColor,
            //                 borderRadius: BorderRadius.all(
            //                   Radius.circular(18),
            //                 ),
            //               ),
            //               child: ValentineTab()),
            //         ),
            //       ],
            //     ),
            //   ],
            //   shrinkWrap: true,
            //   scrollDirection: Axis.vertical,
            //   addAutomaticKeepAlives: false,
            // ),
          ],
        ),
      ),
    );
  }
}
