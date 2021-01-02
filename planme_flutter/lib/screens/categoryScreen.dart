import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/fontStyle.dart';
import 'package:planme_flutter/configs/route.dart' show categoryRoute;
import '../widgets/category/category_overview.dart';

class CategoryScreen extends StatelessWidget {
  static final routeName = categoryRoute;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "My Category",
                style: titleText,
              )
            ],
          ),
          Expanded(child: CategoryOverview())
        ],
      ),
    );
  }
}
