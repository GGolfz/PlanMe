import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:planme_flutter/configs/color.dart';

class ValentineTab extends StatefulWidget {
  @override
  _ValentineTabState createState() => _ValentineTabState();
}

class _ValentineTabState extends State<ValentineTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 200.0,
      width: 200.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 160.0,
            height: 250.0,
            margin: EdgeInsets.fromLTRB(15.0, 2.0, 20.0, 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  margin: EdgeInsets.fromLTRB(15.0, 20.0, 20.0, 15.0),
                  decoration: BoxDecoration(
                    color: calendarSecondaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        calendarSecondaryColor, BlendMode.color),
                    child: Image.network(
                      "https://storage.googleapis.com/planme_storage/stickers/love-letter.png",
                    ),
                  ),
                ),
                Text(
                  'Love Letter',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: titleColorBlack,
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  'For 5 Achievements',
                  style: TextStyle(fontSize: 10.0),
                )
              ],
            ),
          ),
          Container(
            width: 160.0,
            height: 250.0,
            margin: EdgeInsets.fromLTRB(15.0, 2.0, 20.0, 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  margin: EdgeInsets.fromLTRB(15.0, 20.0, 20.0, 15.0),
                  decoration: BoxDecoration(
                    color: calendarSecondaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        calendarSecondaryColor, BlendMode.color),
                    child: Image.network(
                        "https://storage.googleapis.com/planme_storage/stickers/rose.png"),
                  ),
                ),
                Text(
                  'Rose',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: titleColorBlack,
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  'For 5 Achievements',
                  style: TextStyle(fontSize: 10.0),
                )
              ],
            ),
          ),
          Container(
            width: 160.0,
            height: 250.0,
            margin: EdgeInsets.fromLTRB(15.0, 2.0, 20.0, 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  margin: EdgeInsets.fromLTRB(15.0, 20.0, 20.0, 15.0),
                  decoration: BoxDecoration(
                    color: calendarSecondaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        calendarSecondaryColor, BlendMode.color),
                    child: Image.network(
                        "https://storage.googleapis.com/planme_storage/stickers/chocolate-bar.png"),
                  ),
                ),
                Text(
                  'Chocolate Bar',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: titleColorBlack,
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  'For 5 Achievements',
                  style: TextStyle(fontSize: 10.0),
                )
              ],
            ),
          ),
          Container(
            width: 160.0,
            height: 250.0,
            margin: EdgeInsets.fromLTRB(15.0, 2.0, 20.0, 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  margin: EdgeInsets.fromLTRB(15.0, 20.0, 20.0, 15.0),
                  decoration: BoxDecoration(
                    color: calendarSecondaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        calendarSecondaryColor, BlendMode.color),
                    child: Image.network(
                      "https://storage.googleapis.com/planme_storage/stickers/star.png",
                    ),
                  ),
                ),
                Text(
                  'Star',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: titleColorBlack,
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  'For 5 Achievements',
                  style: TextStyle(fontSize: 10.0),
                )
              ],
            ),
          ),
          Container(
            width: 160.0,
            height: 250.0,
            margin: EdgeInsets.fromLTRB(15.0, 2.0, 20.0, 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  margin: EdgeInsets.fromLTRB(15.0, 20.0, 20.0, 15.0),
                  decoration: BoxDecoration(
                    color: calendarSecondaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        calendarSecondaryColor, BlendMode.color),
                    child: Image.network(
                        "https://storage.googleapis.com/planme_storage/stickers/love-letter.png"),
                  ),
                ),
                Text(
                  'Love Letter',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: titleColorBlack,
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  'For 5 Achievements',
                  style: TextStyle(fontSize: 10.0),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
