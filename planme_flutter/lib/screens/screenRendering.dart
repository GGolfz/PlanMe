import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/fontStyle.dart';
import 'package:planme_flutter/configs/route.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/widgets/calendar/addEvent.dart';
import 'calendarScreen.dart';
import 'timerScreen.dart';
import 'reportScreen.dart';
import 'achievementScreen.dart';
import 'categoryScreen.dart';
import 'errorScreen.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/layout/bottomNavigator.dart';
import '../widgets/category/category_edit.dart';

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
      case categoryRoute:
        return CategoryScreen();
      default:
        return ErrorScreen();
    }
  }

  Widget _renderFloating() {
    if (currentRoute == calendarRoute) {
      return FloatingActionButton(
          backgroundColor: iconColor,
          onPressed: () {
            showDialog(
                context: context,
                builder: (ctx) {
                  return AddEvent();
                });
          },
          child: Icon(
            Icons.add,
            size: 32,
          ));
    }
    if (currentRoute == categoryRoute) {
      return FloatingActionButton(
          backgroundColor: iconColor,
          onPressed: () {
            showDialog(
                context: context,
                builder: (ctx) {
                  return CategoryEdit(null, "add");
                });
          },
          child: Icon(
            Icons.add,
            size: 32,
          ));
    }

    return null;
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
      floatingActionButton: _renderFloating(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
