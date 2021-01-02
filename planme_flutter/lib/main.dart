import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/providers/achievementProvider.dart';
import 'package:planme_flutter/providers/categoryProvider.dart';
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
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Authenicate(),
          ),
          ChangeNotifierProxyProvider<Authenicate, UserCategory>(
              create: (ctx) => UserCategory(null, []),
              update: (ctx, auth, prev) {
                return UserCategory(
                    auth.token, prev == null ? [] : prev.category);
              }),
          ChangeNotifierProxyProvider<Authenicate, UserAchievement>(
              create: (ctx) => UserAchievement(null, []),
              update: (ctx, auth, prev) {
                return UserAchievement(
                    auth.token, prev == null ? [] : prev.achievements);
              })
        ],
        child: Consumer<Authenicate>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Plan Me',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: auth.isAuth
                ? ScreenRendering()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? Scaffold(
                                backgroundColor: landingBackgroundColor,
                                body: Text('...'),
                              )
                            : LoginScreen(),
                  ),
            routes: {'/calendar': (ctx) => ScreenRendering()},
          ),
        ));
  }
}
