import 'package:acadamicConnect/Utility/Resources.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'Profiles/ProfilePage.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);
  static String pageName = string.setting;

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildInkWell(
                  context: context,
                  icon: FontAwesomeIcons.user,
                  onTap: () {
                    kopenPage(context, ProfilePage());
                  },
                  subtitle: string.profile_subtitle,
                  title: string.profile),
              buildInkWell(
                  context: context,
                  icon: FontAwesomeIcons.signOutAlt,
                  onTap: () {},
                  subtitle: string.logout_subtitle,
                  title: string.logout),
              buildInkWell(
                  context: context,
                  icon: FontAwesomeIcons.solidMoon,
                  onTap: changeBrightness,
                  subtitle: string.dark_theme_subtitle,
                  title: string.dark_theme),
              buildInkWell(
                  context: context,
                  icon: Icons.contact_mail,
                  onTap: () {},
                  subtitle: string.about_subtitle,
                  title: string.about),
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildInkWell(
      {BuildContext context,
      Function onTap,
      String title,
      String subtitle,
      IconData icon}) {
    return InkWell(
      splashColor: Colors.red[100],
      onTap: onTap,
      child: ListTile(
        trailing: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold
              // fontFamily: 'Ninto',
              ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
