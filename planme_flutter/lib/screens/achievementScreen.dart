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
    return Container(
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
          SizedBox(height: 12),
          Expanded(child: SingleChildScrollView(child: Achievements()))
        ],
      ),
    );
  }
}
