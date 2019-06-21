import 'package:acadamicConnect/Components/ColumnReusableCardButton.dart';
import 'package:acadamicConnect/Utility/Resources.dart';
import 'package:acadamicConnect/Utility/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'MessagingScreen.dart';
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
    return SafeArea(
          child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, i) => ColumnReusableCardButton(
                    tileColor: _randomColor.randomColor(
                      colorSaturation: ColorSaturation.mediumSaturation,
                      colorBrightness: ColorBrightness.dark,
                      colorHue: ColorHue.blue,
                    ),
                    label: 'Teacher $i',
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
}
