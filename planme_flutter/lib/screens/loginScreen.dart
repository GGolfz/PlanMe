import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/fontStyle.dart';
import '../widgets/login/appLogo.dart';
// import '../widgets/login/googleAuth.dart';
import '../widgets/login/authenicateForm.dart';
import '../widgets/login/layoutRender.dart';

class LoginScreen extends StatelessWidget {
  final renderList = [
    appLogo(),
    renderText("plan", landingTitleText),
    renderText("me", landingSubTitleText),
    SizedBox(
      height: 40,
    ),
    AuthenicateForm(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: landingBackgroundColor,
      body: Container(
          padding: EdgeInsets.only(top: 120),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...renderList.map((e) => renderRowCenter(e)),
              ],
            ),
          )),
    );
  }
}
