import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/route.dart' show calendarRoute;

class CalendarScreen extends StatelessWidget {
  static final routeName = calendarRoute;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello Plan Me THIS IS Calendar"),
    );
  }
}
