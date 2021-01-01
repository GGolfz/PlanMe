import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/route.dart' show calendarRoute;
import 'package:planme_flutter/widgets/calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {
  static final routeName = calendarRoute;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(15),
        child: PlanMeCalendar(title: "My Calendar"));
  }
}
