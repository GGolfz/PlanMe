import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/fontStyle.dart';

class AchievementAlert extends StatelessWidget {
  final title;
  final image;
  final List<dynamic> achievement;
  AchievementAlert(this.achievement, this.title, this.image);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.all(40),
        title: Row(
          children: [
            Text(
              "Achievement Unlock !",
              style: titleText,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        content: Container(
          height: 220,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    'https://storage.googleapis.com/planme_storage/stickers/$image',
                    fit: BoxFit.contain,
                  ))
            ]),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: subTitleText,
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    child: Container(
                      height: 40,
                      width: 100,
                      child: Icon(
                        Icons.check,
                        color: deepWhite,
                        size: 40,
                      ),
                      decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (this.achievement.length > 0) {
                        showDialog(
                            context: context,
                            builder: (ctx) => AchievementAlert(
                                this.achievement.length > 1
                                    ? this.achievement.sublist(1)
                                    : [],
                                this.achievement[0]["level_name"],
                                this.achievement[0]["level_img"]));
                      }
                    })
              ],
            )
          ]),
        ));
  }
}
