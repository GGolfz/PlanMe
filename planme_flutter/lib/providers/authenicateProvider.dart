import 'package:flutter/foundation.dart';
import '../model/authenicateException.dart';

class UserInfo {
  final String email;
  final String password;
  UserInfo({@required this.email, @required this.password});
}

class Authenicate with ChangeNotifier {
  // Wait for implementing backend
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
