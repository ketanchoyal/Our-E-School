import 'package:acadamicConnect/Components/ColumnReusableCardButton.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssignmentsPage extends StatefulWidget {
  const AssignmentsPage({Key key}) : super(key: key);

  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  bool isTeacher = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: TopBar(
          title: 'Assignments',
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
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, i) => ColumnReusableCardButton(
                    label: 'Subject $i',
                    icon: FontAwesomeIcons.bookOpen,
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) => SubjectPage(
                      //           pageLabel: 'Subject $i',
                      //         ),
                      //   ),
                      // );
                    },
                    height: 70,
                  ),
            )),
      ),
    );
  }
}
