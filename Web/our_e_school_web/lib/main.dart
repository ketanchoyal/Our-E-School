import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oureschoolweb/app/locator.dart';
import 'package:oureschoolweb/app/router.gr.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
        ClampingScrollWrapper.builder(context, widget),
        maxWidth: 1400,
        minWidth: 500,
        defaultScale: false,
        breakpoints: [
          ResponsiveBreakpoint.resize(
            500,
            name: MOBILE,
          ),
          ResponsiveBreakpoint.resize(
            600,
            name: MOBILE,
          ),
          ResponsiveBreakpoint.resize(
            850,
            name: TABLET,
          ),
          ResponsiveBreakpoint.autoScaleDown(
            1000,
            name: TABLET,
          ),
          ResponsiveBreakpoint.autoScale(
            1200,
            name: DESKTOP,
          ),
          ResponsiveBreakpoint.autoScale(
            2460,
            name: "4K",
          ),
        ],
        background: Container(
          color: Color(0xFFF5F5F5),
        ),
      ),
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
