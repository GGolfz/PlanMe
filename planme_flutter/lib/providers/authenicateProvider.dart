import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../model/authenicateException.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:planme_flutter/configs/api.dart';
import 'dart:convert';

class UserInfo {
  final String email;
  final String password;
  UserInfo({@required this.email, @required this.password});
}

class Authenicate with ChangeNotifier {
  String _token;
  Authenicate();

  String get token {
    return _token;
  }

  bool get isAuth {
    return _token != null;
  }

  Future<List<dynamic>> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      throw "Error";
    }
    final extractedUserData = prefs.getString('userData');
    _token = json.decode(extractedUserData)['token'];
    notifyListeners();
    prefs.clear();
    try {
      final response = await Dio().get(baseURL + '/auth/isAuth?token=$_token');
      return response.data['achievements'].toList();
    } catch (error) {
      prefs.clear();
      _token = null;
      throw "Error";
    }
  }

  Future<List<dynamic>> login(UserInfo userInfo) async {
    if (userInfo.email == "" && userInfo.password == "") {
      throw AuthenicateException("Email is required", "Password is required");
    }
    if (userInfo.email == "") {
      throw AuthenicateException("Email is required", null);
    }
    if (userInfo.password == "") {
      throw AuthenicateException(null, "Password is required");
    }
    try {
      final response = await Dio().post(baseURL + '/auth/login',
          data: {"email": userInfo.email, "password": userInfo.password});
      final token = response.data['token'];
      _token = token;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': token,
        },
      );
      prefs.setString('userData', userData);
      return response.data['achievements'].toList();
    } catch (error) {
      throw AuthenicateException(null, "Invalid username or password");
    }
  }

  Future<List<dynamic>> register(UserInfo userInfo) async {
    if (userInfo.email == "" && userInfo.password == "") {
      throw AuthenicateException("Email is required", "Password is required");
    }
    if (userInfo.email == "") {
      throw AuthenicateException("Email is required", null);
    }
    if (userInfo.password == "") {
      throw AuthenicateException(null, "Password is required");
    }
    try {
      final response = await Dio().post(baseURL + '/auth/register',
          data: {"email": userInfo.email, "password": userInfo.password});
      final token = response.data['token'];
      _token = token;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': token,
        },
      );
      prefs.setString('userData', userData);
      return response.data['achievements'].toList();
    } catch (error) {
      throw AuthenicateException(null, "Email is already used");
    }
  }
}
