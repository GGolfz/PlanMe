import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/route.dart';
import 'calendarScreen.dart';
import 'timerScreen.dart';
import 'reportScreen.dart';
import 'achievementScreen.dart';
import 'errorScreen.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/layout/bottomNavigator.dart';

class ScreenRendering extends StatefulWidget {
  @override
  _ScreenRenderingState createState() => _ScreenRenderingState();
}

class _ScreenRenderingState extends State<ScreenRendering> {
  var currentRoute = '/calendar';
  Widget _renderScreen() {
    switch (currentRoute) {
      case calendarRoute:
        return CalendarScreen();
      case timerRoute:
        return TimerScreen();
      case reportRoute:
        return ReportScreen();
      case achievementRoute:
        return AchievementScreen();
      default:
        return ErrorScreen();
    }
  }

  void _navigate(String route) {
    setState(() {
      currentRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlanMeAppBar(),
      body: _renderScreen(),
      bottomNavigationBar: PlanMeBottomNagivatorBar(_navigate, currentRoute),
    );
  }
}
