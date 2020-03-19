import 'package:flutter/material.dart';
import 'package:oureschoolweb/components/footer.dart';
import 'package:oureschoolweb/components/menuBar.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  ResponsiveRegisterForm(),
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

class ResponsiveRegisterForm extends StatelessWidget {
  const ResponsiveRegisterForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {

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

