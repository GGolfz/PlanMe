import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:planme_flutter/configs/api.dart';

class Achievement {
  int _id;
  String _img;
  String _name;
  String _description;
  bool _own;
  Achievement(this._id, this._name, this._description, this._img, this._own);
  int get id {
    return this._id;
  }

  String get img {
    return this._img;
  }

  String get name {
    return this._name;
  }

  String get description {
    return this._description;
  }

  bool get own {
    return this._own;
  }
}

class AchievementGroup {
  String _name;
  List<Achievement> _achievementList;
  AchievementGroup(this._name, this._achievementList);
  String get name {
    return this._name;
  }

  List<Achievement> get achievements {
    return this._achievementList;
  }
}

class UserAchievement with ChangeNotifier {
  List<AchievementGroup> _achievements;
  String token;
  int lvl;
  UserAchievement(this.token, this._achievements, this.lvl);
  List<AchievementGroup> get achievements {
    return this._achievements;
  }

  Future<void> fetchData() async {
    final response = await Dio().get(baseURL + '/achievement?token=' + token);
    List<AchievementGroup> ach = [];
    final data = response.data["data"].toList();
    data.forEach((el) {
      String name = el["achievement_name"];
      List<Achievement> achlist = [];
      el["achievement_list"].toList().forEach((data) {
        achlist.add(Achievement(data["level_id"], data["level_name"],
            data["level_description"], data["level_img"], data["finish"]));
      });
      ach.add(AchievementGroup(name, achlist));
    });
    lvl = response.data["lvl"];
    _achievements = ach;
    notifyListeners();
  }
}
