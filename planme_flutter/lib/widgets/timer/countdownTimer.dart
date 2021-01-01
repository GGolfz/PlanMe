import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/fontStyle.dart';

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Duration _duration = Duration(minutes: 25);
  Duration _tempDuration;
  void _startTimer() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return DialogTimer(_duration);
        });
  }

  void _editDuration() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
              height: 300,
              padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
              color: CupertinoColors.white,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        setState(() {
                          _duration = _tempDuration;
                          _tempDuration = null;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text("Save"),
                    ),
                  ],
                ),
                CupertinoTimerPicker(
                  onTimerDurationChanged: (duration) {
                    _tempDuration = duration;
                  },
                )
              ]));
        });
  }

  Widget formatDuration(Duration duration) {
    String formatted;
    if (duration.inHours != 0) {
      formatted =
          '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
      return Text(
        formatted,
        style: TextStyle(
            fontFamily: 'Nunito', fontWeight: FontWeight.bold, fontSize: 40),
      );
    } else {
      formatted =
          '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
      return Text(
        formatted,
        style: TextStyle(
            fontFamily: 'Nunito', fontWeight: FontWeight.bold, fontSize: 54),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: backgroundColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(color: Color(0xFF8FC3FF), width: 6)),
                  child: formatDuration(_duration),
                )
              ],
            ),
            Row(
              children: [
                renderIcon(Icon(Icons.play_arrow), _startTimer),
                renderIcon(Icon(Icons.edit), _editDuration),
              ],
            )
          ],
        ));
  }
}

Widget renderIcon(Icon icon, Function onPress) {
  return IconButton(icon: icon, onPressed: onPress);
}

class DialogTimer extends StatelessWidget {
  final Duration duration;
  DialogTimer(this.duration);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (ctx) {
                return Dialog(
                  child: Column(
                    children: [
                      Text("Do you sure to close ?"),
                      RaisedButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      RaisedButton(
                        child: Text("Yes"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                );
              });
        },
        child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("must be not test");
                        },
                        child: Container(
                          width: 300,
                          height: 300,
                          child: CircularCountDownTimer(
                            duration: duration.inSeconds,
                            width: 200,
                            height: 200,
                            color: Colors.white,
                            isReverse: true,
                            textStyle: TextStyle(fontSize: 40),
                            fillColor: Color(0xFF8FC3FF),
                          ),
                        ),
                      ),
                    ]))));
  }
}
