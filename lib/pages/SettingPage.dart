import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);
  static String pageName = 'Setting';

  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: ListTile(
              trailing: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "Logout",
                style: TextStyle(fontWeight: FontWeight.bold
                    // fontFamily: 'Ninto',
                    ),
              ),
              subtitle: Text(
                "Only if you remember your password",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              changeBrightness();
            },
            child: ListTile(
              trailing: Icon(
                Icons.wb_sunny,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "Dark Theme",
                style: TextStyle(fontWeight: FontWeight.bold
                    // fontFamily: 'Ninto',
                    ),
              ),
              subtitle: Text(
                "Tap to change Theme",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              trailing: Icon(
                Icons.contact_mail,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "About!",
                style: TextStyle(fontWeight: FontWeight.bold
                    // fontFamily: 'Ninto',
                    ),
              ),
              subtitle: Text(
                "Contact us",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
