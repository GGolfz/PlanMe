import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart' show categoryColor;
import 'package:dio/dio.dart';
import 'package:planme_flutter/configs/api.dart';

class Category {
  final String _categoryId;
  final String _categoryName;
  final String _colorCode;
  Category(this._categoryId, this._categoryName, this._colorCode);

  Color get color {
    return categoryColor[this._colorCode];
  }

  String get id {
    return this._categoryId;
  }

  String get colorCode {
    return this._colorCode;
  }

  String get name {
    return this._categoryName;
  }
}

class UserCategory with ChangeNotifier {
  List<Category> category = [];
  final String token;

  UserCategory(this.token, this.category);

  Future<void> fetchData() async {
    final response = await Dio().get(baseURL + '/category?token=' + token);
    List<Category> cat = [];
    response.data.toList().forEach((el) =>
        cat.add(Category(el["cid"], el["category_name"], el["color_code"])));
    category = cat;
    notifyListeners();
  }

  Future<void> createCategory(String categoryName, String colorCode) async {
    try {
      await Dio().post(baseURL + '/category', data: {
        "token": token,
        "category_name": categoryName,
        "color_code": colorCode
      });
      fetchData();
      return;
    } catch (error) {
      return;
    }
  }

  Future<void> editCategory(
      String categoryId, String categoryName, String colorCode) async {
    try {
      await Dio().put(baseURL + '/category', data: {
        "token": token,
        "cid": categoryId,
        "category_name": categoryName,
        "color_code": colorCode
      });
      fetchData();
      return;
    } catch (error) {
      return;
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      if (category.length == 1) {
        throw "You must have at least 1 category";
      } else {
        await Dio().delete(baseURL + '/category', data: {
          "token": token,
          "cid": categoryId,
        });
        fetchData();
        return;
      }
    } catch (error) {
      if (error == "You must have at least 1 category") {
        throw error;
      }
      return;
    }
  }
}
