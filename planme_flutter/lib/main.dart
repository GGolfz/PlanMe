import 'package:flutter/material.dart';
import 'package:planme_flutter/widgets/appbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(appBar: PlanMeAppBar(), body: Center(child:Text("Hello Plan Me"))));
  }
}
