import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:planme_flutter/configs/api.dart';

class Event {}

class UserEvent with ChangeNotifier {
  String token;
  List<String> events;
  UserEvent(this.token, this.events);
  Future<void> createEvent(String name, String cid, DateTime date) async {
    try {
      await Dio().post(baseURL + '/event', data: {
        "token": token,
        "event_name": name == '' ? 'Event' : name,
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
