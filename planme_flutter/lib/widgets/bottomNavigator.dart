import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/route.dart';

class PlanMeBottomNagivatorBar extends StatelessWidget {
  final Function _navigate;
  PlanMeBottomNagivatorBar(this._navigate);
  final iconList = [
    {'src': 'calendar.png', 'route': calendarRoute},
    {'src': 'clock.png', 'route': timerRoute},
    {'src': 'chart.png', 'route': reportRoute},
    {'src': 'achieve.png', 'route': achievementRoute}
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 12,
      child: Container(
        height: 64,
        margin: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ...iconList.map((item) {
              return PlanMeNagivatorBarItem(
                  item['src'], item['route'], _navigate);
            }),
          ],
        ),
      ),
    );
  }
}

class PlanMeNagivatorBarItem extends StatelessWidget {
  final String src;
  final String route;
  final Function _navigate;
  PlanMeNagivatorBarItem(this.src, this.route, this._navigate);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 40,
        icon: SizedBox(
          height: 48,
          width: 48,
          child: Image.network(
            "https://storage.googleapis.com/planme_storage/icons/$src",
            fit: BoxFit.contain,
          ),
        ),
        onPressed: () {
          _navigate(route);
        });
  }
}
