import 'package:flutter/material.dart';

Widget googleAuth() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    width: 260,
    height: 50,
    padding: EdgeInsets.all(2),
    color: Color(0xFF5185EC),
    child: Row(
      children: [
        Container(
          width: 46,
          height: 46,
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: SizedBox(
              height: 24,
              width: 24,
              child: Image.network(
                'https://storage.googleapis.com/planme_storage/icons/google.png',
                fit: BoxFit.contain,
              )),
        ),
        Container(
          width: 210,
          height: 50,
          alignment: Alignment.center,
          child: Text(
            "Sign in with Google",
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
  );
}
