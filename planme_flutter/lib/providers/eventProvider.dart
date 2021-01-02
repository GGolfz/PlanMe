import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Event {}

class UserEvent with ChangeNotifier {
  String token;
  List<String> events;
  UserEvent(this.token, this.events);
  Future<void> createEvent(String name, String cid, DateTime date) async {
    try {
      await Dio().post('http://localhost:5000/api' + '/event', data: {
        "token": token,
        "event_name": name,
        "cid": cid,
        "event_date": "${date.year}-${date.month}-${date.day}"
      });
      // fetchData();
      return;
    } catch (error) {
      return;
    }
  }
}
