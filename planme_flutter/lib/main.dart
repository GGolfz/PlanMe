import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/providers/achievementProvider.dart';
import 'package:planme_flutter/providers/categoryProvider.dart';
import 'package:planme_flutter/providers/eventProvider.dart';
import 'package:planme_flutter/providers/reportProvider.dart';
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
          ChangeNotifierProxyProvider<Authenicate, ReportProvider>(
              create: (ctx) => ReportProvider(null),
              update: (ctx, auth, prev) {
                return ReportProvider(auth.token);
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
                        final context =
                            navigatorKey.currentState.overlay.context;
                        if (alert != null && alert.length > 0) {
                          showDialog(
                              context: context,
                              builder: (ctx) => AchievementAlert(
                                  alert.length > 1 ? alert.sublist(1) : [],
                                  alert[0]['level_name'],
                                  alert[0]['level_img']));
                        }
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
