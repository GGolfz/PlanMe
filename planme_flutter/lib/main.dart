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
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Authenicate(),
          )
        ],
        child: Consumer<Authenicate>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: auth.authInfo.isAuth
                ? ScreenRendering()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? Scaffold(
                                body: Text('...'),
                              )
                            : LoginScreen(),
                  ),
            routes: {'/calendar': (ctx) => ScreenRendering()},
          ),
        ));
  }
}
