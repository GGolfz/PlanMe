import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/fontStyle.dart';
import 'package:planme_flutter/providers/reportProvider.dart';
import 'package:provider/provider.dart';

class PlanMeBarChart extends StatefulWidget {
  @override
  _PlanMeBarChartState createState() => _PlanMeBarChartState();
}

class _PlanMeBarChartState extends State<PlanMeBarChart> {
  int touchedIndex;
  var isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      fetchData();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  Future<void> fetchData() async {
    Provider.of<ReportProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportProvider>(
      builder: (ctx, value, child) => value.dayReport != null
          ? BarChart(mainBarData(value.dayReport))
          : CircularProgressIndicator(),
    );
  }

  BarChartData mainBarData(WeekDayReport weekDayReport) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBottomMargin: -20,
            tooltipBgColor: secondaryColor,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt() - 1) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
              }
              return BarTooltipItem(
                  weekDay +
                      '\n' +
                      (rod.y).round().toString() +
                      ' min' +
                      (rod.y.round() > 1 ? 's' : ''),
                  TextStyle(color: deepWhite));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => normalText.copyWith(
              color: deepBlack, fontSize: 14, fontWeight: FontWeight.bold),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt() - 1) {
              case 0:
                return 'MON';
              case 1:
                return 'TUE';
              case 2:
                return 'WED';
              case 3:
                return 'THU';
              case 4:
                return 'FRI';
              case 5:
                return 'SAT';
              case 6:
                return 'SUN';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => normalText.copyWith(
              color: deepBlack, fontSize: 12, fontWeight: FontWeight.bold),
          interval: weekDayReport.max == 0 ? 60 : weekDayReport.max / 5,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
              left: BorderSide(width: 1, color: subTitleColorBlack),
              bottom: BorderSide(width: 1, color: subTitleColorBlack))),
      barGroups: showingGroups(weekDayReport),
    );
  }

  List<BarChartGroupData> showingGroups(weekDayReport) {
    List<BarChartGroupData> bcga = [];
    if (weekDayReport != null) {
      int i = 0;
      weekDayReport.data.forEach((e) {
        bcga.add(makeGroupData(e.date.weekday, e.times * 1.0,
            isTouched: i == touchedIndex));
        i += 1;
      });
    }
    return bcga;
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          colors:
              isTouched ? [getChartPrimaryColor[x]] : [getChartPrimaryColor[x]],
          width: width,
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
}
