import 'package:ourESchool/UI/Utility/custom_icons.dart';
import 'package:ourESchool/UI/Widgets/ColumnReusableCardButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ourESchool/imports.dart';
import 'MessagingScreen.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:random_color/random_color.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);
  static String pageName = string.chat;

  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return BaseView<StudentListPageModel>(
      onModelReady: (model) => model.getStudent(),
      builder: (context, model ,child) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: model.studentsSnapshot.length,
                  itemBuilder: (context, i) => ColumnReusableCardButton(
                    tileColor: _randomColor.randomColor(
                      colorSaturation: ColorSaturation.mediumSaturation,
                      colorBrightness: ColorBrightness.dark,
                      colorHue: ColorHue.blue,
                    ),
                    label: 'Teacher ${model.studentsSnapshot[i].data.length}',
                    icon: CustomIcons.profile,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => MessagingScreen(),
                        ),
                      );
                    },
                    height: 70,
                  ),
                )),
          ),
        );
      }
    );
  }
}
