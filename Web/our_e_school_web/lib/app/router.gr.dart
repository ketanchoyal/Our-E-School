// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:oureschoolweb/ui/pages/add_user/add_user.dart';
import 'package:oureschoolweb/ui/pages/home_page.dart';
import 'package:oureschoolweb/ui/pages/login/login_page.dart';
import 'package:oureschoolweb/ui/pages/register/register_page.dart';

abstract class Routes {
  static const homePage = '/';
  static const loginPage = '/login-page';
  static const registerPage = '/register-page';
  static const addUser = '/add-user';
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.homePage:
        if (hasInvalidArgs<HomePageArguments>(args)) {
          return misTypedArgsRoute<HomePageArguments>(args);
        }
        final typedArgs = args as HomePageArguments ?? HomePageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomePage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.loginPage:
        if (hasInvalidArgs<LoginPageArguments>(args)) {
          return misTypedArgsRoute<LoginPageArguments>(args);
        }
        final typedArgs = args as LoginPageArguments ?? LoginPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.registerPage:
        if (hasInvalidArgs<RegisterPageArguments>(args)) {
          return misTypedArgsRoute<RegisterPageArguments>(args);
        }
        final typedArgs =
            args as RegisterPageArguments ?? RegisterPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => RegisterPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.addUser:
        if (hasInvalidArgs<AddUserArguments>(args)) {
          return misTypedArgsRoute<AddUserArguments>(args);
        }
        final typedArgs = args as AddUserArguments ?? AddUserArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddUser(key: typedArgs.key),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//HomePage arguments holder class
class HomePageArguments {
  final Key key;
  HomePageArguments({this.key});
}

//LoginPage arguments holder class
class LoginPageArguments {
  final Key key;
  LoginPageArguments({this.key});
}

//RegisterPage arguments holder class
class RegisterPageArguments {
  final Key key;
  RegisterPageArguments({this.key});
}

//AddUser arguments holder class
class AddUserArguments {
  final Key key;
  AddUserArguments({this.key});
}
