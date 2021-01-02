import 'package:flutter/material.dart';
import 'package:planme_flutter/widgets/category/category_list.dart';
import 'package:provider/provider.dart';
import 'package:planme_flutter/providers/categoryProvider.dart';

class CategoryOverview extends StatefulWidget {
  @override
  _CategoryOverviewState createState() => _CategoryOverviewState();
}

class _CategoryOverviewState extends State<CategoryOverview> {
  var _isLoading = false;
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<UserCategory>(context, listen: false).fetchData();
      setState(() {
        _isLoading = false;
      });
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading ? CircularProgressIndicator() : CategoryList(),
    );
  }
}
