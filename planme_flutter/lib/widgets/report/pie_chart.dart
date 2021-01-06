import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/fontStyle.dart';
import 'package:planme_flutter/providers/reportProvider.dart';
import 'package:provider/provider.dart';

class PlanMePieChart extends StatefulWidget {
  @override
  _PlanMePieChartState createState() => _PlanMePieChartState();
}

class _PlanMePieChartState extends State<PlanMePieChart> {
  int touchedIndex;
  @override
  Widget build(BuildContext context) {
    return Consumer<ReportProvider>(
      builder: (ctx, value, child) => value.categoryReport != null
          ? Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: 250,
                      height: 250,
                      child: PieChart(
                        PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse.touchInput
                                        is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  touchedIndex = -1;
                                } else {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                }
                              });
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 30,
                            sections: showingSections(value.categoryReport)),
                      )),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: getIndicator(value.categoryReport)),
                ],
              )
            ]):Container()
    );
  }

  Widget indicator(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(shape: BoxShape.rectangle, color: color),
        ),
        SizedBox(
          width: 4,
        ),
        Text(text, style: subTitleText.copyWith(fontSize: 12, color: deepBlack))
      ],
    );
  }

  List<Widget> getIndicator(WeekCategoryReport weekCategoryReport) {
    List<Widget> returnedIndicator = [];
    int i = 0;
    weekCategoryReport.data.forEach((element) {
      returnedIndicator.add(indicator(pieChartColor[i], element.categoryName));
      returnedIndicator.add(SizedBox(
        height: 8,
      ));
      i += 1;
    });
    return returnedIndicator.sublist(0, returnedIndicator.length - 1);
  }

  List<PieChartSectionData> showingSections(
      WeekCategoryReport weekCategoryReport) {
    List<PieChartSectionData> pcsd = [];
    int i = 0;
    weekCategoryReport.data.forEach((element) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 16 : 12;
      final double radius = isTouched ? 60 : 50;
      pcsd.add(PieChartSectionData(
          color: pieChartColor[i],
          value: element.times * 1.0,
          title: ((element.times / weekCategoryReport.sum) * 100)
                  .toStringAsFixed(2) +
              '%',
          radius: radius,
          titleStyle:
              titleText.copyWith(color: deepWhite, fontSize: fontSize)));
      i += 1;
    });

    return pcsd;
  }
}
