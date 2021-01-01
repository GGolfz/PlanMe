import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/route.dart' show timerRoute;
import 'package:planme_flutter/widgets/timer/countdownTimer.dart';

class TimerScreen extends StatelessWidget {
  static final routeName = timerRoute;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CountdownTimer(),
    );
  }
}
