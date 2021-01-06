import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/fontStyle.dart';
import 'package:planme_flutter/providers/categoryProvider.dart';
import 'package:planme_flutter/providers/eventProvider.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

enum DialogPage { main, name, category, date }

class _AddEventState extends State<AddEvent> {
  String _eventName;
  List<Category> categoryList;
  Category _eventCategory;
  DateTime _eventDate;
  DialogPage _currentPage = DialogPage.main;
  var isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<UserCategory>(context).fetchData();
      categoryList = Provider.of<UserCategory>(context).category;
      _eventName = '';
      _eventCategory = categoryList[0];
      _eventDate = DateTime.now();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  Future<void> createEvent() async {
    Provider.of<UserEvent>(context, listen: false)
        .createEvent(_eventName, _eventCategory.id, _eventDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 265,
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
      placeholderStyle: TextStyle(fontFamily: 'Nunito'),
      controller: textEditingController,
    );
  }

  Widget _buildDatePicker(Function onChange, DateTime initial) {
    return CupertinoTheme(
      data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: TextStyle(
                  fontFamily: 'Nunito', color: deepBlack, fontSize: 16))),
      child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: onChange,
          initialDateTime: initial),
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
    Category tempVal =
        _eventCategory == null ? categoryList[0] : _eventCategory;
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
        CategorySelector((value) {
          tempVal = value;
        }, tempVal, categoryList)
      ],
    );
  }

  Widget _buildDatePage() {
    DateTime tempVal = _eventDate;
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
        Container(
          height: 180,
          child: _buildDatePicker((value) {
            tempVal = value;
          }, tempVal),
        )
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
                  title: Text("Event Name",
                      style: TextStyle(fontFamily: 'Nunito')),
                  trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 5,
                      children: [
                        Text(_eventName,
                            style: TextStyle(fontFamily: 'Nunito')),
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
                      _currentPage = DialogPage.category;
                    });
                  },
                  title: Text("Event Category",
                      style: TextStyle(fontFamily: 'Nunito')),
                  trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 5,
                      children: [
                        Text(_eventCategory.name,
                            style: TextStyle(fontFamily: 'Nunito')),
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
                  title: Text("Event Date",
                      style: TextStyle(fontFamily: 'Nunito')),
                  trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 5,
                      children: [
                        Text(
                            "${_eventDate.day}/${_eventDate.month}/${_eventDate.year}",
                            style: TextStyle(fontFamily: 'Nunito')),
                        Icon(Icons.chevron_right)
                      ]),
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
              child: Text("Cancel", style: TextStyle(fontFamily: 'Nunito')),
            ),
            CupertinoButton(
              onPressed: () async {
                createEvent();
              },
              child: Text("Submit", style: TextStyle(fontFamily: 'Nunito')),
            )
          ],
        )
      ],
    );
  }
}

class CategorySelector extends StatefulWidget {
  final Function onChange;
  final Category initial;
  final List<Category> category;
  CategorySelector(this.onChange, this.initial, this.category);
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  String selected;
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        selected = widget.initial.id;
      });
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              checkColor: widget.category[index].color,
              activeColor: widget.category[index].color,
              value: widget.category[index].id == selected ? true : false,
              title: Text(widget.category[index].name,
                  style: TextStyle(fontFamily: 'Nunito')),
              onChanged: (bool value) {
                setState(() {
                  selected = widget.category[index].id;
                  widget.onChange(widget.category[index]);
                });
              },
            );
          },
          itemCount: widget.category.length,
        ));
  }
}
