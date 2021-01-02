import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:planme_flutter/providers/categoryProvider.dart';
import './category_item.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Category> categoryData =
        Provider.of<UserCategory>(context).category;
    return Container(
        child: categoryData.length == 0
            ? Container()
            : ListView.builder(
                itemBuilder: (ctx, index) => CategoryItem(categoryData[index]),
                itemCount: categoryData.length,
              ));
  }
}
