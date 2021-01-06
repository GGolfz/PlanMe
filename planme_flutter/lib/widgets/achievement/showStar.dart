import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:planme_flutter/configs/color.dart';

class ShowStar extends StatelessWidget {
  final String amount;
  ShowStar(this.amount);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 2.0),
          decoration: BoxDecoration(
            color: appbarColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: <Widget>[
              Text(
                amount,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: titleColorBlack,
                  fontFamily: 'Nunito',
                ),
              ),
              Icon(
                Icons.star,
                size: 30,
                color: thursdayPrimaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
