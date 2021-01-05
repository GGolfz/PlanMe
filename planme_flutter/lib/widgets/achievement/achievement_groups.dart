import 'package:flutter/material.dart';
import './achievement_item.dart';
import 'package:planme_flutter/providers/achievementProvider.dart';
import 'package:planme_flutter/configs/color.dart';

class AchievementGroups extends StatelessWidget {
  final AchievementGroup achievementGroup;
  AchievementGroups(this.achievementGroup);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 8.0, 10.0, 10.0),
            child: Text(
              achievementGroup.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: titleColorBlack,
              ),
            ),
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
                width: 200.0,
                height: 270.0,
                margin: EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0),
                padding: EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0),
                decoration: BoxDecoration(
                  color: appbarColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    height: 300.0,
                    width: 270.0,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          ...achievementGroup.achievements
                              .map((element) => AchievementItem(element))
                        ]))),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      )
    ]);
  }
}
