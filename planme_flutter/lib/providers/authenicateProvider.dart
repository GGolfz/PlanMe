import 'package:flutter/foundation.dart';
import '../model/authenicateException.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  final String email;
  final String password;
  UserInfo({@required this.email, @required this.password});
}

class AuthInfo {
  final String _userId;
  AuthInfo(this._userId);
  String get userId {
    return _userId;
  }

  bool get isAuth {
    return _userId != null;
  }
}

class Authenicate with ChangeNotifier {
  AuthInfo authInfo = AuthInfo(null);
  // Wait for implementing backend
  Future<bool> tryAutoLogin() async {
    // final prefs = await SharedPreferences.getInstance();
    // if (!prefs.containsKey('userData')) {
    //   return false;
    // }
    // final extractedUserData =
    //     prefs.getString('userData') as Map<String, Object>;

    final extractedUserData = {"userId": "mockup"};
    authInfo = AuthInfo(extractedUserData['userId']);
    print(authInfo.isAuth);
    // notifyListeners();
    return true;
  }

  Future<void> login(UserInfo userInfo) async {
    print('Email:' + userInfo.email);
    print('Password:' + userInfo.password);
    if (userInfo.email == "" && userInfo.password == "") {
      throw AuthenicateException(
          "Email is required", "Password is required", "Please try again");
    }
    if (userInfo.email == "") {
      throw AuthenicateException("Email is required", null, "Please try again");
    }
    if (userInfo.password == "") {
      throw AuthenicateException(
          null, "Password is required", "Please try again");
    }
    if (userInfo.email == "test" && userInfo.password != "test") {
      throw AuthenicateException(
          null, "Invalid username or password", "Please try again");
    }
    notifyListeners();
  }

  Future<void> register(UserInfo userInfo) async {
    print("HI");
    throw AuthenicateException(null, null, null);
  }
}
