import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/fontStyle.dart';
import 'package:planme_flutter/configs/route.dart' show reportRoute;
import 'package:planme_flutter/widgets/report/bar_graph.dart';
import 'package:planme_flutter/widgets/report/pie_chart.dart';

class ReportScreen extends StatelessWidget {
  static final routeName = reportRoute;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 40),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Last week report",
              style: titleText,
            )
          ],
        ),
        Expanded(
            child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [PlanMeBarChart()],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [PlanMePieChart()],
              )
            ],
          ),
        ))
      ]),
    );
  }
}
