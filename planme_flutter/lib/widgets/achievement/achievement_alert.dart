import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/fontStyle.dart';

class AchievementAlert extends StatelessWidget {
  final title;
  final image;
  AchievementAlert(this.title, this.image);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(40),
      title: Row(
        children: [Text(title)],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      content: SizedBox(
          width: 100,
          height: 100,
          child: Image.network(
            'https://storage.googleapis.com/planme_storage/stickers/$image',
            fit: BoxFit.contain,
          )),
      actions: [
        RaisedButton(
            color: successColor,
            child: Text(
              "OK",
              style: subTitleText.copyWith(color: deepWhite),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    );
  }
}
