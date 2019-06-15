import 'package:acadamicConnect/pages/WelcomeScreen.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  timeDilation = 2;
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }),
            fontFamily: "Nunito",
            primaryColor: Colors.red,
            accentColor: Colors.redAccent,
            primaryColorDark: Color(0xff0029cb),
            brightness: brightness,
          ),
            themedWidgetBuilder: (context, theme) => MaterialApp(
            theme: theme,
            home: WelcomeScreen(),
          ),
    );
  }
}
