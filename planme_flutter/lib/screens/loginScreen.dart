import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/fontStyle.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: landingBackgroundColor,
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: Image.network(
                  'https://storage.googleapis.com/planme_storage/icons/icon.png',
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "plan",
                style: landingTitleText,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "me",
                style: landingSubTitleText,
              )
            ],
          )
        ],
      )),
    );
  }
}
