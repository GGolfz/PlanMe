import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:planme_flutter/configs/color.dart';

class AllTab extends StatefulWidget {
  @override
  _AllTabState createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
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
                      "https://storage.googleapis.com/planme_storage/stickers/candy-cane.png",
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ),
                Text(
                  'Candy Cane',
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
                        "https://storage.googleapis.com/planme_storage/stickers/gingerbread-man.png"),
                  ),
                ),
                Text(
                  'Gingerbread Man',
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
                        "https://storage.googleapis.com/planme_storage/stickers/christmas-wreath.png"),
                  ),
                ),
                Text(
                  'Christmas Wreath',
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
                        "https://storage.googleapis.com/planme_storage/stickers/candy-cane.png"),
                  ),
                ),
                Text(
                  'Candy Cane',
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
