import 'package:acadamicConnect/pages/WelcomeScreen.dart';
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
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Nunito-Bold",
        // primaryColor: primaryColor,
        primaryColor: Color(0xffF57C00),
        accentColor: Color(0xffFF6D00),
        primaryColorDark: Color(0xff0029cb),
        brightness: Brightness.light,
      ),
      home: WelcomeScreen(),
    );
  }
}
