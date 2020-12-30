import 'package:flutter/material.dart';
import 'package:planme_flutter/screens/screenRendering.dart';
import 'screens/loginScreen.dart';

import 'package:provider/provider.dart';
import 'providers/authenicateProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => Authenicate())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
        routes: {'/calendar': (ctx) => ScreenRendering()},
      ),
    );
  }
}
