import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(
          child: kBackBtn,
          onPressed: () {
            kbackBtn(context);
          },
          title: string.about,
        ),
        body: Container());
  }
}
