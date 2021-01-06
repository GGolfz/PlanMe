import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:planme_flutter/configs/api.dart';

class DayReport {
  DateTime date;
  int times;
  DayReport(this.date, this.times);
}

class WeekDayReport {
  double sum;
  List<DayReport> data;
  double max;
  WeekDayReport(this.sum, this.data, this.max);
}

class CategoryReport {
  String categoryName;
  String colorCode;
  int times;
  CategoryReport(this.categoryName, this.colorCode, this.times);
}

class WeekCategoryReport {
  int sum;
  List<CategoryReport> data;
  WeekCategoryReport(this.sum, this.data);
}

class ReportProvider with ChangeNotifier {
  String token;
  WeekDayReport dayReport;
  WeekCategoryReport categoryReport;
  ReportProvider(this.token);
  Future<void> fetchData() async {
    final dayResponse = await Dio().get(baseURL + '/report/day?token=$token');
    final categoryResponse =
        await Dio().get(baseURL + '/report/category?token=$token');
    List<DayReport> dy = [];
    double md = 0;
    dayResponse.data["data"].toList().forEach((element) {
      dy.add(
          DayReport(DateTime.parse(element["timer_date"]), element["times"]));
      if (element["times"] > md) {
        md = element["times"] * 1.0;
      }
    });
    dayReport = WeekDayReport(dayResponse.data["sum_time"] * 1.0, dy, md);
    List<CategoryReport> cy = [];
    categoryResponse.data["data"].toList().forEach((element) {
      cy.add(CategoryReport(
          element["category_name"], element["color_code"], element["times"]));
    });
    categoryReport = WeekCategoryReport(categoryResponse.data["sum_time"], cy);
    notifyListeners();
  }
}
