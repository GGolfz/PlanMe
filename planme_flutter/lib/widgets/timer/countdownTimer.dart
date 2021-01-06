import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/fontStyle.dart';
import 'package:provider/provider.dart';
import 'package:planme_flutter/providers/categoryProvider.dart';
import 'package:planme_flutter/providers/timerProvider.dart';
import 'package:planme_flutter/widgets/achievement/achievement_alert.dart';

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Duration _duration = Duration(minutes: 25);
  bool isStart = false;
  Duration _tempDuration;
  Category _category;
  Category _tempCategory;
  List<Category> categoryList;
  var isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<UserCategory>(context).fetchData();
      categoryList = Provider.of<UserCategory>(context).category;
      _category = categoryList[0];
      isInit = false;
    }
    super.didChangeDependencies();
  }

  void _startTimer() {
    setState(() {
      isStart = true;
    });
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return DialogTimer(_duration, _onFinish, _onFail);
        });
  }

  void _onFail() {
    setState(() {
      isStart = false;
    });
  }

  Future<void> _onFinish() async {
    setState(() {
      isStart = false;
    });
    final List<dynamic> alert = await Provider.of<Timer>(context, listen: false)
        .saveTimer(_category, _duration);
    if (alert != null && alert.length > 0) {
      showDialog(
          context: context,
          builder: (ctx) => AchievementAlert(
              alert.length > 1 ? alert.sublist(1) : [],
              alert[0]['level_name'],
              alert[0]['level_img']));
    }
  }

  void _editCategory(List<Category> category) {
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
                          if (_tempCategory != null) {
                            _category = _tempCategory;
                            _tempCategory = null;
                          }
                        });
                        Navigator.of(context).pop();
                      },
                      child:
                          Text("Save", style: TextStyle(fontFamily: 'Nunito')),
                    ),
                  ],
                ),
                Expanded(
                    child: CupertinoPicker(
                  itemExtent: 48,
                  children: [
                    ...category
                        .map((e) => Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 4),
                            child: Text(e.name,
                                style: TextStyle(fontFamily: 'Nunito'))))
                        .toList()
                  ],
                  onSelectedItemChanged: (value) {
                    _tempCategory = category[value];
                  },
                ))
              ]));
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
                        if (_tempDuration == Duration.zero) {
                          return;
                        }
                        setState(() {
                          if (_tempDuration != null) {
                            _duration = _tempDuration;
                            _tempDuration = null;
                          }
                        });
                        Navigator.of(context).pop();
                      },
                      child:
                          Text("Save", style: TextStyle(fontFamily: 'Nunito')),
                    ),
                  ],
                ),
                CupertinoTheme(
                  data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                          pickerTextStyle: TextStyle(
                              fontFamily: 'Nunito',
                              color: deepBlack,
                              fontSize: 16))),
                  child: CupertinoTimerPicker(
                    initialTimerDuration: _duration,
                    onTimerDurationChanged: (duration) {
                      _tempDuration = duration;
                    },
                  ),
                )
              ]));
        });
  }

  Widget formatDuration(Duration duration) {
    String formatted;
    if (duration.inHours != 0) {
      formatted =
          '${(duration.inHours).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
      return Text(formatted, style: timerTextNormal);
    } else {
      formatted =
          '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
      return Text(formatted, style: timerTextBig);
    }
  }

  Widget renderIcon(double size, Icon icon, Function onPress) {
    return IconButton(
        color: secondaryColor, iconSize: size, icon: icon, onPressed: onPress);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: backgroundColor,
        child: isStart
            ? Container()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        height: 250,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(250),
                            border:
                                Border.all(color: secondaryColor, width: 6)),
                        child: formatDuration(_duration),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      renderIcon(50, Icon(Icons.play_arrow), _startTimer),
                      SizedBox(width: 10),
                      renderIcon(36, Icon(Icons.edit), _editDuration),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    GestureDetector(
                      child: Wrap(children: [
                        Text(
                          _category.name,
                          style: subTitleText,
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.edit,
                          size: 24,
                          color: subTitleColorBlack,
                        )
                      ]),
                      onTap: () => {_editCategory(categoryList)},
                    )
                  ]),
                ],
              ));
  }
}

class DialogTimer extends StatelessWidget {
  final Duration duration;
  final Function onFinish;
  final Function onFail;
  DialogTimer(this.duration, this.onFinish, this.onFail);
  void showYesNoDialog(BuildContext context) {
    showDialog(
        context: context,
        child: CupertinoAlertDialog(
          title: Text(
            "Stop?",
            style: TextStyle(fontFamily: 'Nunito'),
          ),
          content: Text(
            "Are you sure you want to stop?",
            style: TextStyle(fontFamily: 'Nunito'),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(fontFamily: 'Nunito'),
                )),
            CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  onFail();
                },
                child: Text(
                  "Yes",
                  style: TextStyle(fontFamily: 'Nunito', color: Colors.red),
                )),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showYesNoDialog(context);
        },
        child: Dialog(
            insetPadding: EdgeInsets.all(0),
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 300,
                          height: 300,
                          child: CircularCountDownTimer(
                              duration: duration.inSeconds,
                              width: 200,
                              height: 200,
                              color: Colors.white,
                              isReverse: true,
                              textStyle: duration.inHours > 0
                                  ? timerTextNormalWh
                                  : timerTextBigWh,
                              fillColor: secondaryColor,
                              onComplete: () {
                                Navigator.of(context).pop();
                                onFinish();
                              }),
                        ),
                      ),
                    ]))));
  }
}
