import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/route.dart' show reportRoute;

class ReportScreen extends StatelessWidget {
  static final routeName = reportRoute;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello Plan Me THIS IS REPORT"),
    );
  }
}
