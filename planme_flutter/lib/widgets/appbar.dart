import 'package:flutter/material.dart';
import '../configs/color.dart' show appbarColor;

class PlanMeAppBar extends StatefulWidget implements PreferredSizeWidget {
  PlanMeAppBar({Key key})
      : preferredSize = Size.fromHeight(64),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _PlanMeAppBarState createState() => _PlanMeAppBarState();
}

class _PlanMeAppBarState extends State<PlanMeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      backgroundColor: appbarColor,
      toolbarHeight: 64,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print("Go To Home");
              },
              child: SizedBox(
                height: 54,
                width: 42,
                child: Image.network(
                  'https://storage.googleapis.com/planme_storage/icons/icon.png',
                  fit: BoxFit.contain,
                ),
              ),
            )
          ]),
    );
  }
}
