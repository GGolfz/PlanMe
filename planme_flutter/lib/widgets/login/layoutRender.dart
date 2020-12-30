import 'package:flutter/material.dart';

Widget renderRowCenter(Widget widget) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [widget],
  );
}

Widget renderText(String text, TextStyle style) {
  return Text(
    text,
    style: style,
  );
}
