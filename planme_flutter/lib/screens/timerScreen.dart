import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/route.dart' show timerRoute;

class TimerScreen extends StatelessWidget {
  static final routeName = timerRoute;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello Plan Me THIS IS Timer Screen"),
    );
  }
}
