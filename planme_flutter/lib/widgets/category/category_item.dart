import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/providers/categoryProvider.dart';
import 'package:planme_flutter/widgets/category/category_edit.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final Category categoryData;
  CategoryItem(this.categoryData);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(categoryData.name),
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: categoryData.color,
        ),
      ),
      trailing: Wrap(
        children: [
          IconButton(
              splashRadius: 20,
              icon: Icon(
                Icons.edit,
                size: 24,
                color: Colors.amber,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return CategoryEdit(categoryData, "edit");
                    });
              }),
          IconButton(
              splashRadius: 20,
              icon: Icon(
                Icons.delete,
                size: 24,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return CupertinoAlertDialog(
                        title: Text("Are you sure ?"),
                        content: Text("Do you want to delete this category"),
                        actions: [
                          CupertinoDialogAction(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                              onPressed: () async {
                                await Provider.of<UserCategory>(context,
                                        listen: false)
                                    .deleteCategory(categoryData.id);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(color: errorColor),
                              ))
                        ],
                      );
                    });
              })
        ],
      ),
    );
  }
}
