import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

typedef ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData data);

typedef ThemeDataWithBrightnessBuilder = ThemeData Function(
    Brightness brightness);

class DynamicTheme extends StatefulWidget {
  const DynamicTheme(
      {Key key, this.data, this.themedWidgetBuilder, this.defaultBrightness})
      : super(key: key);

  final ThemedWidgetBuilder themedWidgetBuilder;
  final ThemeDataWithBrightnessBuilder data;
  final Brightness defaultBrightness;

  @override
  DynamicThemeState createState() => DynamicThemeState();

  static DynamicThemeState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<DynamicThemeState>());
  }
}

class DynamicThemeState extends State<DynamicTheme> {
  ThemeData _data;

  Brightness _brightness;

  static const String _sharedPreferencesKey = 'isDark';

  ThemeData get data => _data;

  Brightness get brightness => _brightness;

  @override
  void initState() {
    super.initState();
    _brightness = widget.defaultBrightness;
    _data = widget.data(_brightness);

    loadBrightness().then((bool dark) {
      _brightness = dark ? Brightness.dark : Brightness.light;
      _data = widget.data(_brightness);
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _data = widget.data(_brightness);
  }

  @override
  void didUpdateWidget(DynamicTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    _data = widget.data(_brightness);
  }

  Future<void> setBrightness(Brightness brightness) async {
    setState(() {
      _data = widget.data(brightness);
      _brightness = brightness;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        _sharedPreferencesKey, brightness == Brightness.dark ? true : false);
  }

  void setThemeData(ThemeData data) {
    setState(() {
      _data = data;
    });
  }

  Future<bool> loadBrightness() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_sharedPreferencesKey) ??
        widget.defaultBrightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return widget.themedWidgetBuilder(context, _data);
  }
}
