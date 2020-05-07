import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oureschoolweb/app/locator.dart';
import 'package:oureschoolweb/app/router.gr.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/utils/bouncing_scroll_behavior.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1300,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint(breakpoint: 450, name: MOBILE),
            ResponsiveBreakpoint(breakpoint: 600, name: MOBILE, scale: true),
            ResponsiveBreakpoint(breakpoint: 800, name: TABLET, scale: true),
            ResponsiveBreakpoint(breakpoint: 1000, name: TABLET, scale: true),
            ResponsiveBreakpoint(breakpoint: 1200, name: DESKTOP, scale: true),
            ResponsiveBreakpoint(breakpoint: 2460, name: "4K", scale: true),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      initialRoute: Routes.homePage,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      theme: Theme.of(context).copyWith(
          platform: TargetPlatform.android,
          accentColor: Colors.black,
          primaryColor: Colors.white),
      debugShowCheckedModeBanner: false,
    );
  }
}
