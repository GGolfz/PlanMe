import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/providers/achievementProvider.dart';
import 'package:planme_flutter/providers/categoryProvider.dart';
import 'package:planme_flutter/providers/eventProvider.dart';
import 'package:planme_flutter/providers/timerProvider.dart';
import 'package:planme_flutter/screens/screenRendering.dart';
import 'screens/loginScreen.dart';
import 'widgets/achievement/achievement_alert.dart';
import 'package:provider/provider.dart';
import 'providers/authenicateProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();
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
              }),
          ChangeNotifierProxyProvider<Authenicate, UserEvent>(
              create: (ctx) => UserEvent(null, {}),
              update: (ctx, auth, prev) {
                return UserEvent(auth.token, prev == null ? [] : prev.events);
              }),
          ChangeNotifierProxyProvider<Authenicate, Timer>(
              create: (ctx) => Timer(null),
              update: (ctx, auth, prev) {
                return Timer(auth.token);
              }),
        ],
        child: Consumer<Authenicate>(
          builder: (ctx, auth, _) => MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Plan Me',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: auth.isAuth
                ? ScreenRendering()
                : FutureBuilder(
                    future: Future<bool>.sync(() async {
                      try {
                        final alert = await auth.tryAutoLogin();
                        alert.reversed.forEach((el) {
                            final context =
                                navigatorKey.currentState.overlay.context;
                            showDialog(
                                context: context,
                                builder: (ctx) => AchievementAlert(
                                    el['level_name'], el['level_img']));
                        });
                        return true;
                      } catch (error) {
                        return false;
                      }
                    }),
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
