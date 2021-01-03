import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:planme_flutter/configs/api.dart';

class Event {
  String event_id;
  String event_name;
  DateTime event_date;
  String color_code;
  String category;
  bool finish;
  Event(this.event_id, this.event_name, this.event_date, this.color_code,
      this.category, this.finish);
}

class UserEvent with ChangeNotifier {
  String token;
  Map<DateTime, List<Event>> events;
  DateTime selected;
  UserEvent(this.token, this.events);
  Future<void> fetchData(DateTime date) async {
    try {
      Map<DateTime, List<Event>> temp = {};
      this.selected = date;
      final response = await Dio().get('http://localhost:5000/api' +
          '/event?token=$token&y=${date.year}&m=${date.month}');
      response.data.toList().forEach((e) {
        List<String> d = e['event_date'].split('-');
        DateTime date =
            DateTime(int.parse(d[0]), int.parse(d[1]), int.parse(d[2]));
        Event ev = Event(e['event_id'], e['event_name'], date, e['color_code'],
            e['category'], e['finish']);
        if (temp[date] == null) {
          temp[date] = [ev];
        } else {
          temp[date].add(ev);
        }
      });
      events = temp;
      notifyListeners();
      return;
    } catch (error) {
      return;
    }
  }

  Future<void> createEvent(String name, String cid, DateTime date) async {
    try {
      await Dio().post(baseURL + '/event', data: {
        "token": token,
        "event_name": name == '' ? 'Event' : name,
        "cid": cid,
        "event_date": "${date.year}-${date.month}-${date.day}"
      });
    } catch (error) {}
    await fetchData(selected);
    return;
  }

  Future<void> toggleEvent(String event_id, bool value) async {
    try {
      await Dio().put('http://localhost:5000/api' + '/event',
          data: {"event_id": event_id, "token": token, "finish": value});
      fetchData(selected);
    } catch (error) {}
    await fetchData(selected);
    return;
  }

  Future<void> deleteEvent(String event_id) async {
    try {
      await Dio().delete('http://localhost:5000/api' + '/event',
          data: {"event_id": event_id, "token": token});
    } catch (error) {}
    await fetchData(selected);
    return;
  }
}
