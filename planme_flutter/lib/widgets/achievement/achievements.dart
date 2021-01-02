import 'package:flutter/material.dart';
import 'achievement_groups.dart';
import 'package:planme_flutter/providers/achievementProvider.dart';
import 'package:provider/provider.dart';

class Achievements extends StatefulWidget {
  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  var isInit = true;
  var isLoading = false;
  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<UserAchievement>(context, listen: false).fetchData();
      setState(() {
        isLoading = false;
      });
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserAchievement>(
      builder: (ctx, ach, child) {
        return ListView(
          children: [
            ...ach.achievements.map((element) {
              return AchievementGroups(element);
            })
          ],
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          addAutomaticKeepAlives: false,
        );
      },
    );
  }
}
