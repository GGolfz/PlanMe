import 'package:flutter/material.dart';

Widget appLogo() {
  return SizedBox(
    height: 120,
    width: 120,
    child: Image.network(
      'https://storage.googleapis.com/planme_storage/icons/icon.png',
      fit: BoxFit.contain,
    ),
  );
}
