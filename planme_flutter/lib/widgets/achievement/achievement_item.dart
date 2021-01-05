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
      height: 250.0,
      margin: EdgeInsets.fromLTRB(15.0, 2.0, 20.0, 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.fromLTRB(15.0, 20.0, 20.0, 15.0),
            decoration: BoxDecoration(
              color: achievement.own ? achievementColor[achievement.id] : calendarSecondaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: achievement.own
                ? Image.network(
                    'https://storage.googleapis.com/planme_storage/stickers/${achievement.img}')
                : ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        calendarSecondaryColor, BlendMode.color),
                    child: Image.network(
                        'https://storage.googleapis.com/planme_storage/stickers/${achievement.img}'),
                  ),
          ),
          Text(
            achievement.name,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: titleColorBlack,
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            achievement.description,
            style: TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}
