import 'package:acadamicConnect/Components/ColumnReusableCardButton.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:acadamicConnect/pages/Dashboard/Assignment/AssignmentOpener.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubjectPage extends StatefulWidget {
  final String pageLabel;
  const SubjectPage({@required this.pageLabel});

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  bool isTeacher = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: TopBar(
          title: widget.pageLabel,
          child: kBackBtn,
          onPressed: kbackBtn(context)
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
                  label: 'Chapter $i',
                  icon: FontAwesomeIcons.bookReader,
                  onPressed: () {
                    kopenPage(
                      context,
                      AssignmentOpener(
                        url: 'http://www.pdf995.com/samples/pdf.pdf',
                        chapterNo: 'Chapter $i',
                      ),
                    );
                  },
                  height: 70,
                ),
          ),
        ),
      ),
    );
  }
}
