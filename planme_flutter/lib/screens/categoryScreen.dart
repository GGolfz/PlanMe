import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/route.dart' show categoryRoute;

class CategoryScreen extends StatelessWidget {
  static final routeName = categoryRoute;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello Plan Me THIS IS Category"),
    );
  }
}
