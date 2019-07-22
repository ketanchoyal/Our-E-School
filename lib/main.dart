import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:ourESchool/UI/pages/Home.dart';
import 'package:ourESchool/UI/pages/Profiles/GuardianProfile.dart';
import 'package:ourESchool/UI/pages/Profiles/ProfilePage.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
// import 'package:flutter/foundation.dart'
//     show debugDefaultTargetPlatformOverride;
import 'package:ourESchool/locator.dart';
import 'package:provider/provider.dart';

import 'UI/Widgets/DynamicThemeChanger.dart';
import 'UI/pages/WelcomeScreen.dart';
import 'core/Models/User.dart';
import 'core/viewmodel/ProfilePageModel.dart';

void main() {
  // debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  timeDilation = 2;
  Provider.debugCheckInvalidValueType = null;
  setupLocator();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.controller(
          initialData: User(),
          builder: (context) => locator<ProfilePageModel>().loggedInUserStream,
        ),
        StreamProvider<bool>.controller(
          initialData: false,
          builder: (context) =>
              locator<AuthenticationServices>().isUserLoggedInStream,
        ),
        StreamProvider<UserType>.controller(
          initialData: UserType.UNKNOWN,
          builder: (context) =>
              locator<AuthenticationServices>().userTypeStream,
        ),
        StreamProvider<FirebaseUser>.controller(
          initialData: locator<AuthenticationServices>().firebaseUser,
          builder: (context) =>
              locator<AuthenticationServices>().fireBaseUserStream,
        )
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our E-School',
      theme: theme,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        Home.id: (context) => Home(),
        ProfilePage.id: (context) => ProfilePage(),
        GuardianProfilePage.id: (context) => GuardianProfilePage(
              title: 'Guardian Profile',
            ),
      },
      home: Provider.of<bool>(context) ? Home() : WelcomeScreen(),
    );
  }
}
