import 'package:acadamicConnect/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() {
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
      title: 'Flutter Demo',
      theme: ThemeData(
        // fontFamily: "Title",
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
