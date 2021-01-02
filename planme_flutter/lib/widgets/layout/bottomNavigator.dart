import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/route.dart';

class PlanMeBottomNagivatorBar extends StatelessWidget {
  final Function _navigate;
  final String current;
  PlanMeBottomNagivatorBar(this._navigate, this.current);
  final iconList = [
    {'src': 'calendar.png', 'route': calendarRoute},
    {'src': 'clock.png', 'route': timerRoute},
    {'src': 'chart.png', 'route': reportRoute},
    {'src': 'achieve.png', 'route': achievementRoute},
    {'src': 'category.png', 'route': categoryRoute}
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
              return PlanMeNagivatorBarItem(item['src'], item['route'],
                  _navigate, current == item['route']);
            }),
          ],
        ),
      ),
    );
  }
}

class PlanMeNagivatorBarItem extends StatelessWidget {
  final String _src;
  final String _route;
  final Function _navigate;
  final bool _isCurrent;
  PlanMeNagivatorBarItem(
      this._src, this._route, this._navigate, this._isCurrent);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 32,
        icon: SizedBox(
          height: 48,
          width: 48,
          child: Image.network(
            _isCurrent
                ? "https://storage.googleapis.com/planme_storage/icons/$_src"
                : "https://storage.googleapis.com/planme_storage/icons/u_$_src",
            fit: BoxFit.contain,
          ),
        ),
        onPressed: () {
          _navigate(_route);
        });
  }
}
