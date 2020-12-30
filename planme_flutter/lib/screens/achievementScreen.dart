import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/route.dart' show achievementRoute;

class AchievementScreen extends StatelessWidget {
  static final routeName = achievementRoute;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello Plan Me THIS IS ACHIEVEMENT"),
    );
  }
}
