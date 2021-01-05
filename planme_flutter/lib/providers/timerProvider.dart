import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:planme_flutter/configs/api.dart';
import 'categoryProvider.dart';

class Timer with ChangeNotifier {
  String token;
  Timer(this.token);
  Future<List<dynamic>> saveTimer(Category category, Duration duration) async {
    try {
      DateTime date = DateTime.now();
      final response = await Dio().post(baseURL + '/timer', data: {
        "token": token,
        "cid": category.id,
        "timer_time": duration.inSeconds,
        "timer_date": "${date.year}-${date.month}-${date.day}"
      });
      return response.data['achievements'].toList();
    } catch (error) {
      return [];
    }
  }
}
