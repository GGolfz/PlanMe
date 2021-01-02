import 'package:flutter/foundation.dart';
import 'package:planme_flutter/widgets/achievement/achievement_groups.dart';

class Achievement {
  String _img;
  String _name;
  String _description;
  bool _own;
  Achievement(this._name, this._description, this._img, this._own);
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
  List<Achievement> _achievement_list;
  AchievementGroup(this._name, this._achievement_list);
  String get name {
    return this._name;
  }

  List<Achievement> get achievements {
    return this._achievement_list;
  }
}

class UserAchievement with ChangeNotifier {
  List<AchievementGroup> _achievements;
  String token;
  UserAchievement(this.token, this._achievements);
  List<AchievementGroup> get achievements {
    return this._achievements;
  }

  Future<void> fetchData() async {
    // Mock Data
    _achievements = [
      AchievementGroup("Christmas Collection", [
        Achievement("Candy Cane", "level 1", "candy-cane.png", true),
        Achievement("Gingerbread Man", "level 2", "gingerbread-man.png", false),
        Achievement(
            "Christmas Wreath", "level 3", "christmas-wreath.png", false),
        Achievement("Star", "level 4", "star.png", false),
        Achievement("Candy Cane", "level 5", "candy-cane.png", false)
      ]),
      AchievementGroup("Valentine Collection", [
        Achievement("Love Letter", "level 1", "love-letter.png", true),
        Achievement("Rose", "level 2", "rose.png", false),
        Achievement("Chocolate Bar", "level 3", "chocolate-bar.png", false),
        Achievement("Star", "level 4", "star.png", false),
        Achievement("Love Letter", "level 5", "love-letter.png", false),
        Achievement("Candy Cane", "level 6", "candy-cane.png", false)
      ]),
      AchievementGroup("Christmas Collection", [
        Achievement("Candy Cane", "level 1", "candy-cane.png", true),
        Achievement("Gingerbread Man", "level 2", "gingerbread-man.png", false),
        Achievement(
            "Christmas Wreath", "level 3", "christmas-wreath.png", false),
        Achievement("Star", "level 4", "star.png", false),
        Achievement("Candy Cane", "level 5", "candy-cane.png", false)
      ]),
    ];
    // notifyListeners();
  }
}
