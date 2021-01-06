import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/providers/achievementProvider.dart';

class AchievementItem extends StatelessWidget {
  final Achievement achievement;
  AchievementItem(this.achievement);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      height: 300.0,
      margin: EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 0.0),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.fromLTRB(15.0, 20.0, 20.0, 15.0),
            decoration: BoxDecoration(
              color: achievement.own
                  ? achievementColor[achievement.id]
                  : calendarSecondaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: achievement.own
                ? Image.network(
                    'https://storage.googleapis.com/planme_storage/achievement_list/${achievement.img}')
                : ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        calendarSecondaryColor, BlendMode.color),
                    child: Image.network(
                        'https://storage.googleapis.com/planme_storage/achievement_list/${achievement.img}'),
                  ),
          ),
          Text(
            achievement.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: titleColorBlack,
              fontFamily: 'Nunito',
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            achievement.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Nunito',
            ),
          ),
        ],
      ),
    );
  }
}
