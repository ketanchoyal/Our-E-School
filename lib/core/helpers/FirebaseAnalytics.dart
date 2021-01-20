// import 'package:firebase_analytics/firebase_analytics.dart';

abstract class AnalyticsScreen {
  String get screenName;
  // FirebaseAnalytics constructor reuses a single instance, so it's ok to call like this
  void setCurrentScreen() => print(screenName);
  // FirebaseAnalytics().setCurrentScreen(screenName: screenName);
}
