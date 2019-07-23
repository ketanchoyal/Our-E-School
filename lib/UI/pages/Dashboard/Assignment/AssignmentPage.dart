import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/AssignmentBottomSheet.dart';
import 'package:ourESchool/UI/Widgets/ColumnReusableCardButton.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/pages/shared/PDFOpener.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class AssignmentsPage extends StatefulWidget {
  const AssignmentsPage({Key key}) : super(key: key);

  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  bool isTeacher = false;
  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    var userType = Provider.of<UserType>(context);
    if (userType == UserType.TEACHER) {
      isTeacher = true;
    }
    return Container(
      child: Scaffold(
        appBar: TopBar(
            title: string.assignment,
            child: kBackBtn,
            onPressed: () {
              kbackBtn(context);
            }),
        floatingActionButton: Visibility(
          visible: isTeacher,
          child: FloatingActionButton(
            onPressed: () {
              // buildShowDialogBox(context);
              // showAboutDialog(context: context);
              showModalBottomSheet(
                elevation: 10,
                isScrollControlled: true,
                context: context,
                builder: (context) => AssignmentBottomSheet(),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.red,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, i) => ColumnReusableCardButton(
                tileColor: _randomColor.randomColor(
                    colorBrightness: ColorBrightness.veryDark,
                    colorHue: ColorHue.purple,
                    colorSaturation: ColorSaturation.highSaturation),
                label: 'Subject $i',
                icon: FontAwesomeIcons.bookOpen,
                onPressed: () {
                  kopenPage(
                    context,
                    PDFOpener(
                      url: 'http://www.pdf995.com/samples/pdf.pdf',
                      title: 'Assignment $i',
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
