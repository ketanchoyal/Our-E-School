import 'package:acadamicConnect/Components/ColumnReusableCardButton.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key key}) : super(key: key);

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  bool isTeacher = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: TopBar(
          title: 'Announcement',
          child: kBackBtn,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        floatingActionButton: Visibility(
          visible: isTeacher,
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
            backgroundColor: Colors.red,
          ),
        ),
        body: Container(),
      ),
    );
  }
}
