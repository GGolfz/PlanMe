import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:planme_flutter/configs/fontStyle.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

enum DialogPage { main, name, category, date }

class _AddEventState extends State<AddEvent> {
  String _eventName;
  String _eventCategory;
  String _eventDate;
  DialogPage _currentPage = DialogPage.main;
  @override
  void initState() {
    _eventName = '';
    _eventCategory = '';
    _eventDate = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 262,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
            child: _buildDialog()),
      ),
    );
  }

  Widget _buildDialog() {
    switch (_currentPage) {
      case DialogPage.main:
        return _buildMainPage();
      case DialogPage.name:
        return _buildNamePage();
      case DialogPage.category:
        return _buildCategoryPage();
      case DialogPage.date:
        return _buildDatePage();
      default:
        return _buildMainPage();
    }
  }

  Widget _pageTitle(String text, Function onBack) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 30,
          child: IconButton(
              onPressed: () {
                setState(() {
                  onBack();
                  _currentPage = DialogPage.main;
                });
              },
              icon: Icon(
                Icons.chevron_left,
                size: 30,
              )),
        ),
        Text(
          text,
          style: titleText,
        ),
        SizedBox(width: 30)
      ],
    );
  }

  Widget _buildTextField(Function onChange, String text, String initial) {
    TextEditingController textEditingController =
        TextEditingController(text: initial);
    return CupertinoTextField(
      padding: EdgeInsets.all(10),
      onChanged: onChange,
      placeholder: text,
      controller: textEditingController,
    );
  }

  Widget _buildNamePage() {
    String tempVal = _eventName;
    String title = "Event Name";
    return Column(
      children: [
        _pageTitle(title, () {
          setState(() {
            _eventName = tempVal;
          });
        }),
        SizedBox(
          height: 10,
        ),
        _buildTextField((value) {
          tempVal = value;
        }, title, tempVal)
      ],
    );
  }

  Widget _buildCategoryPage() {
    String tempVal = _eventCategory;
    String title = "Event Category";
    return Column(
      children: [
        _pageTitle(title, () {
          setState(() {
            _eventCategory = tempVal;
          });
        }),
        SizedBox(
          height: 10,
        ),
        _buildTextField((value) {
          tempVal = value;
        }, title, tempVal)
      ],
    );
  }

  Widget _buildDatePage() {
    String tempVal = _eventDate;
    String title = "Event Date";
    return Column(
      children: [
        _pageTitle(title, () {
          setState(() {
            _eventDate = tempVal;
          });
        }),
        SizedBox(
          height: 10,
        ),
        _buildTextField((value) {
          tempVal = value;
        }, title, tempVal)
      ],
    );
  }

  Widget _buildMainPage() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  "Add Event",
                  style: titleText,
                ))
          ],
        ),
        Container(
          height: 146,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            child: Column(
              children: [
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  onTap: () {
                    setState(() {
                      _currentPage = DialogPage.name;
                    });
                  },
                  title: Text("Event Name"),
                  trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 5,
                      children: [Text(_eventName), Icon(Icons.chevron_right)]),
                ),
                Divider(
                  height: 5,
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  onTap: () {
                    setState(() {
                      _currentPage = DialogPage.category;
                    });
                  },
                  title: Text("Event Category"),
                  trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 5,
                      children: [
                        Text(_eventCategory),
                        Icon(Icons.chevron_right)
                      ]),
                ),
                Divider(
                  height: 5,
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  onTap: () {
                    setState(() {
                      _currentPage = DialogPage.date;
                    });
                  },
                  title: Text("Event Date"),
                  trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 5,
                      children: [Text(_eventDate), Icon(Icons.chevron_right)]),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            CupertinoButton(
              onPressed: () {},
              child: Text("Submit"),
            )
          ],
        )
      ],
    );
  }
}
