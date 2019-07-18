import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:ourESchool/UI/pages/Home.dart';
import 'package:ourESchool/UI/pages/Profiles/ProfilePage.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
// import 'package:flutter/foundation.dart'
//     show debugDefaultTargetPlatformOverride;
import 'package:ourESchool/locator.dart';
import 'package:provider/provider.dart';

import 'UI/Widgets/DynamicThemeChanger.dart';
import 'UI/pages/WelcomeScreen.dart';
import 'core/viewmodel/MainPageModel.dart';

void main() {
  // debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  timeDilation = 2;
  Provider.debugCheckInvalidValueType = null;
  setupLocator();
  runApp(
    MyApp(),
  );
}

//TODO: Create a light weight class which have loggedIn UserType so that it can be accessed everywhere

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  AuthenticationServices _auth = locator<AuthenticationServices>();
  @override
  Widget build(BuildContext context) {
    _auth.isLoggedIn();
    return MultiProvider(
      providers: [
        StreamProvider<MainPageModel>.controller(
          initialData: MainPageModel.initials(),
          builder: (context) => locator<StreamController<MainPageModel>>(),
        ),
      ],
      child: DynamicTheme(
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
        themedWidgetBuilder: (context, theme) => new OurSchoolApp(
          theme: theme,
        ),
      ),
    );
  }
}

class OurSchoolApp extends StatelessWidget {
  const OurSchoolApp({
    Key key,
    @required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MainPageModel>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our E-School',
      theme: theme,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        Home.id: (context) => Home(),
        ProfilePage.id: (context) => ProfilePage()
      },
      home: model.isUserLoggedIn ? Home() : WelcomeScreen(),
    );
  }
}
