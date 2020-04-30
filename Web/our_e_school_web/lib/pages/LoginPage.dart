import 'package:flutter/material.dart';
import 'package:oureschoolweb/components/Resources.dart';
import 'package:oureschoolweb/components/footer.dart';
import 'package:oureschoolweb/components/menuBar.dart';
import 'package:oureschoolweb/helper/responsive_reducers.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: <Widget>[
                  MenuBar(),
                  ResponsiveLoginForm(),
                  Footer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ResponsiveLoginForm extends StatelessWidget {
  const ResponsiveLoginForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isDesktop) {
          return DesktopLoginUI();
        }

        if (sizingInformation.isTablet) {
          return TabletLoginUI();
        }

        if (sizingInformation.isMobile) {
          return MobileLoginUI();
        }

        return DesktopLoginUI();
      },
    );
  }
}

class MobileLoginUI extends StatelessWidget {
  const MobileLoginUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 500,
          child: Card(
            elevation: 10,
            // color: Colors.redAccent,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Opacity(
                    opacity: 0.4,
                    child: Image.asset(
                      ImageAssets.login_image2x,
                      fit: BoxFit.fitWidth,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Container(

                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DesktopLoginUI extends StatelessWidget {
  const DesktopLoginUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          flex: 8,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Card(
              elevation: 0,
              // color: Colors.blueGrey,
              child: Image.asset(
                ImageAssets.login_image2x,
                fit: BoxFit.fitWidth,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 12,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Card(
              elevation: 10,
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}

class TabletLoginUI extends StatelessWidget {
  const TabletLoginUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Stack(
                  children: [
                    Positioned(
                      left: -50,
                      right: 10,
                      top: 10,
                      bottom: 10,
                      child: Image.asset(
                        ImageAssets.login_image2x,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        Flexible(
          flex: 5,
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 10,
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}