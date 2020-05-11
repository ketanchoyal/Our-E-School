import 'package:flutter/material.dart';
import 'package:oureschoolweb/ui/components/footer.dart';
import 'package:oureschoolweb/ui/components/MenuBar/menuBar.dart';
import 'package:oureschoolweb/ui/helper/Enums.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: <Widget>[
              MenuBar(selectedPage: SelectedPage.REGISTER),
              ResponsiveRegisterForm(),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class ResponsiveRegisterForm extends StatelessWidget {
  const ResponsiveRegisterForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveWrapper.of(context).equals(MOBILE) ||
            ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
        } else if (ResponsiveWrapper.of(context).equals(TABLET)) {
        } else {}
        return DesktopLoginUI();
      },
    );
  }
}

class DesktopLoginUI extends StatelessWidget {
  const DesktopLoginUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Card(
            elevation: 0,
            color: Colors.blueGrey,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Card(
            elevation: 10,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }
}
