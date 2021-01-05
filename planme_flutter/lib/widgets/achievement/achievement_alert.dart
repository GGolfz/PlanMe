import 'package:flutter/material.dart';

class AchievementAlert extends StatelessWidget {
  final title;
  final image;
  AchievementAlert(this.title, this.image);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(title),
    );
  }
}
