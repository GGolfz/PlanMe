import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart' show categoryColor;
import 'package:dio/dio.dart';
import 'package:planme_flutter/configs/api.dart';
import 'dart:convert';

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
    final response = await Dio()
        .get('http://localhost:5000' + '/api/category?token=' + token);
    List<Category> cat = [];
    response.data.toList().forEach((el) =>
        cat.add(Category(el["cid"], el["category_name"], el["color_code"])));
    category = cat;
    notifyListeners();
  }

  Future<void> createCategory(String categoryName, String colorCode) async {
    try {
      await Dio().post('http://localhost:5000' + '/api/category', data: {
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
      await Dio().put('http://localhost:5000' + '/api/category', data: {
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
      await Dio().delete('http://localhost:5000' + '/api/category', data: {
        "token": token,
        "cid": categoryId,
      });
      fetchData();
      return;
    } catch (error) {
      return;
    }
  }
}
