import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/fontStyle.dart';
import 'package:planme_flutter/providers/categoryProvider.dart';
import 'package:provider/provider.dart';

class CategoryEdit extends StatefulWidget {
  final Category category;
  final String mode;
  CategoryEdit(this.category, this.mode);
  @override
  _CategoryEditState createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  String colorCode;
  TextEditingController _textController;
  @override
  void initState() {
    if (widget.mode == 'edit') {
      colorCode = widget.category.colorCode;
      _textController = TextEditingController(text: widget.category.name);
    } else {
      colorCode = categoryColor.keys.toList()[0];
      _textController = TextEditingController(text: '');
    }
    super.initState();
  }

  Future<void> onSave() async {
    if (widget.mode == "edit") {
      await Provider.of<UserCategory>(context, listen: false)
          .editCategory(widget.category.id, _textController.text, colorCode);
    } else {
      await Provider.of<UserCategory>(context, listen: false)
          .createCategory(_textController.text, colorCode);
    }
    Navigator.of(context).pop();
  }

  void changeColor(String code) {
    setState(() {
      colorCode = code;
    });
  }

  var borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
          style: BorderStyle.solid, width: 2, color: Color(0xFFEBEBEB)));

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(30),
        width: 350,
        height: 374,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (widget.mode == 'add' ? 'Create' : 'Edit') + " Category",
                  style: titleText,
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: categoryColor[colorCode],
                    ))
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      errorBorder: borderStyle,
                      focusedErrorBorder: borderStyle,
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      fillColor: Colors.white,
                      filled: true),
                ))
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...categoryColor.keys
                    .toList()
                    .sublist(0, 5)
                    .map((key) => colorSelect(key, changeColor))
                    .toList()
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...categoryColor.keys
                    .toList()
                    .sublist(5)
                    .map((key) => colorSelect(key, changeColor))
                    .toList()
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                CupertinoButton(child: Text("Save"), onPressed: onSave)
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget colorSelect(String code, Function onClick) {
  return GestureDetector(
    onTap: () {
      onClick(code);
    },
    child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: categoryColor[code],
        )),
  );
}
