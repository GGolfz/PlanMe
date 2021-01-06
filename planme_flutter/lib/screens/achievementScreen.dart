import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/route.dart' show achievementRoute;
import 'package:planme_flutter/providers/achievementProvider.dart';
import 'package:planme_flutter/widgets/achievement/showStar.dart';
import 'package:planme_flutter/widgets/achievement/achievements.dart';
import 'package:provider/provider.dart';

class AchievementScreen extends StatelessWidget {
  static final routeName = achievementRoute;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Consumer<UserAchievement>(
              builder: (ctx, ach, ch) => ShowStar(ach.lvl.toString())),
          Text(
            'Achievements',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: titleColorBlack,
              fontFamily: 'Nunito',
            ),
          ),
          SizedBox(height: 12),
          Expanded(child: SingleChildScrollView(child: Achievements()))
        ],
      ),
    );
  }
}
