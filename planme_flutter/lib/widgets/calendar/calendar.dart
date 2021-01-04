import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planme_flutter/providers/categoryProvider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/fontStyle.dart';
import 'package:intl/intl.dart' show DateFormat;

class PlanMeCalendar extends StatefulWidget {
  PlanMeCalendar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PlanMeCalendarState createState() => _PlanMeCalendarState();
}

class _PlanMeCalendarState extends State<PlanMeCalendar>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  DateTime _selectedDay;
  var isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      isInit = false;
      _selectedDay = DateTime.now();

      _events = {
        _selectedDay: [
          {
            "Name": "A01",
            "Category": "Matematics",
            "ColorCode": "A01",
            "Finish": true
          },
          {
            "Name": "A02",
            "Category": "Science",
            "ColorCode": "A02",
            "Finish": false
          },
          {
            "Name": "A03",
            "Category": "Computer",
            "ColorCode": "A03",
            "Finish": false
          },
        ],
      };

      _selectedEvents = _events[_selectedDay] ?? [];
      _calendarController = CalendarController();

      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      );

      _animationController.forward();
      Provider.of<UserCategory>(context).fetchData();
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    setState(() {
      _selectedEvents = events;
      _selectedDay = day;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {}

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {}

  bool isSameDate(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  String formatDate(DateTime date) {
    return (isSameDate(date, DateTime.now()) ? 'Today, ' : '') +
        DateFormat("dd MMMM yyyy").format(_selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      _buildTableCalendarWithBuilders(),
      const SizedBox(height: 8.0),
      Container(
          padding: EdgeInsets.only(left: 25),
          alignment: Alignment.centerLeft,
          child: Text(
            formatDate(_selectedDay),
            style: titleText,
          )),
      const SizedBox(height: 8.0),
      Expanded(child: _buildEventList()),
    ]);
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      initialCalendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
          cellMargin: EdgeInsets.all(8),
          contentDecoration: BoxDecoration(color: backgroundColor),
          outsideDaysVisible: true,
          weekendStyle: calendarNormalText,
          weekdayStyle: calendarNormalText,
          eventDayStyle: calendarNormalText,
          outsideStyle:
              calendarNormalText.copyWith(color: calendarSecondaryColor),
          outsideHolidayStyle:
              calendarNormalText.copyWith(color: calendarSecondaryColor),
          outsideWeekendStyle:
              calendarNormalText.copyWith(color: calendarSecondaryColor),
          todayStyle: calendarNormalText,
          selectedStyle: calendarNormalText),
      daysOfWeekStyle: DaysOfWeekStyle(
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: backgroundColor, width: 20)),
          weekdayStyle: calendarHeaderText,
          weekendStyle: calendarHeaderText),
      headerStyle: HeaderStyle(
          centerHeaderTitle: true,
          formatButtonVisible: false,
          titleTextStyle: titleText,
          leftChevronIcon: Icon(
            Icons.chevron_left,
            size: 30,
          ),
          leftChevronPadding:
              EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            size: 30,
          ),
          rightChevronPadding:
              EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6)),
      builders: CalendarBuilders(
        dowWeekdayBuilder: (
          context,
          date,
        ) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
            height: 24,
            alignment: Alignment.center,
            child: Text(
              date,
              style: calendarHeaderText,
            ),
          );
        },
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
              opacity:
                  Tween(begin: 0.0, end: 1.0).animate(_animationController),
              child: _selectedBuilder(date));
        },
        todayDayBuilder: (context, date, _) {
          return _selectedBuilder(date);
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
            children.add(
              Positioned(
                  bottom: 10,
                  child: Icon(
                    Icons.circle,
                    color: calendarPrimaryColor,
                    size: 6,
                  )),
            );
          }
          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _selectedBuilder(DateTime date) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70), color: secondaryColor),
      width: 70,
      height: 70,
      child: Text(
        '${date.day}',
        style: calendarNormalText.copyWith(
            color: deepWhite, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildEventList() {
    return ListView.separated(
      separatorBuilder: (ctx, index) => Divider(),
      itemBuilder: (ctx, index) {
        final event = _selectedEvents[index];
        return Dismissible(
            key: ValueKey(index),
            background: Container(
                color: Theme.of(context).errorColor,
                child: Icon(Icons.delete, color: Colors.white, size: 40),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20)),
            onDismissed: (direction) {
              print("Deleted");
            },
            confirmDismiss: (direction) {
              return showDialog(
                  context: context,
                  builder: (ctx) => CupertinoAlertDialog(
                        title: Text('Are you sure?'),
                        content: Text('Do you want to remove this item?'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text(
                              'Yes',
                              style: TextStyle().copyWith(color: errorColor),
                            ),
                            onPressed: () {
                              Navigator.of(ctx).pop(true);
                            },
                          )
                        ],
                      ));
            },
            direction: DismissDirection.endToStart,
            child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              checkColor: categoryColor[event["ColorCode"].toString()],
              activeColor: categoryColor[event["ColorCode"].toString()],
              value: event["Finish"].toString() == "true" ? true : false,
              title: Text(event["Name"].toString()),
              subtitle: Text(event["Category"].toString()),
              onChanged: (bool value) {
                setState(() {
                  event["Finish"] = value;
                });
              },
            ));
      },
      itemCount: _selectedEvents.length,
    );
  }
}
