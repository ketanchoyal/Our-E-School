import 'package:acadamicConnect/Components/ColumnReusableCardButton.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/Resources.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:random_color/random_color.dart';

import '../../PDFOpener.dart';

class AssignmentsPage extends StatefulWidget {
  const AssignmentsPage({Key key}) : super(key: key);

  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  bool isTeacher = true;
  RandomColor _randomColor = RandomColor();

  String _fileName;
  String _path;
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              buildShowDialogBox(context);
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

  Future buildShowDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(string.upload_assignment),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: string.title,
                  // hintStyle: TextStyle(fontFamily: "Nunito-Regular"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: string.description_optional,
                  // hintStyle: TextStyle(fontFamily: "Nunito-Regular"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller,
                enabled: false,
                decoration: InputDecoration(
                  hintText: string.file_name,
                  // hintStyle: TextStyle(fontFamily: "Subtitle"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                _path = await openFileExplorer(FileType.IMAGE, mounted);
                setState(() {
                  _fileName = _path != null ? _path.split('/').last : '...';
                  print(_fileName);
                  if (_fileName.isNotEmpty) {
                    _controller.text = _fileName;
                  }
                });
              },
              child: Icon(Icons.attach_file),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(string.upload),
            ),
          ],
        );
      },
    );
  }
}
