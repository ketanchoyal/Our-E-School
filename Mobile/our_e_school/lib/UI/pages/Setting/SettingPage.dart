import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/DynamicThemeChanger.dart';
import 'package:ourESchool/UI/pages/About/About.dart';
import 'package:ourESchool/UI/pages/Login/ForgotPassword.dart';
import 'package:ourESchool/UI/pages/Profiles/GuardianProfile.dart';
import 'package:ourESchool/UI/pages/Profiles/ProfilePage.dart';
import 'package:ourESchool/UI/pages/WelcomeScreen.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/core/viewmodel/LoginPageModel.dart';
import 'package:ourESchool/locator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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

  SharedPreferencesHelper preferencesHelper =
      locator<SharedPreferencesHelper>();

  @override
  Widget build(BuildContext context) {
    LoginPageModel model = locator<LoginPageModel>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              settingTiles(
                  context: context,
                  icon: FontAwesomeIcons.user,
                  onTap: () {
                    UserType userType = Provider.of<UserType>(context, listen: false);
                    if (userType == UserType.PARENT) {
                      kopenPage(context, GuardianProfilePage());
                    } else {
                      kopenPage(context, ProfilePage());
                    }
                  },
                  subtitle: string.profile_subtitle,
                  title: string.profile),
              settingTiles(
                  context: context,
                  icon: FontAwesomeIcons.signOutAlt,
                  onTap: () async {
                    await model.logoutUser();
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => WelcomeScreen()
                    ),);
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, WelcomeScreen.id, (r) => false);
                  },
                  subtitle: string.logout_subtitle,
                  title: string.logout),
              settingTiles(
                  context: context,
                  icon: FontAwesomeIcons.solidMoon,
                  onTap: changeBrightness,
                  subtitle: string.dark_theme_subtitle,
                  title: string.dark_theme),
              settingTiles(
                  context: context,
                  icon: Icons.restore,
                  onTap: () {
                    kopenPage(context, ForgotPasswordPage());
                  },
                  subtitle: string.send_recovery_mail,
                  title: 'Forgot Password'),
              settingTiles(
                  context: context,
                  icon: Icons.contact_mail,
                  onTap: () async {
                    print((await preferencesHelper.getParentsIds()).toString());
                    kopenPage(context, AboutUs());
                  },
                  subtitle: string.about_subtitle,
                  title: string.about),
            ],
          ),
        ),
      ),
    );
  }

  InkWell settingTiles(
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
