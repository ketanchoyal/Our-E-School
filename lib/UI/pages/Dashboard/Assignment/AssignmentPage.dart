import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/ColumnReusableCardButton.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/pages/shared/PDFOpener.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/viewmodel/AssignmentPageModel.dart';
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

class AssignmentBottomSheet extends StatefulWidget {
  AssignmentBottomSheet({this.model});
  final AssignmentPageModel model;
  @override
  _AssignmentBottomSheetState createState() => _AssignmentBottomSheetState();
}

class _AssignmentBottomSheetState extends State<AssignmentBottomSheet> {
  String _fileName;
  String _path = null;
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 31),
              child: FloatingActionButton(
                onPressed: () async {
                  _path =
                      await openFileExplorer(FileType.ANY, mounted, context);
                  setState(() {
                    _fileName = _path != null ? _path.split('/').last : '...';
                    print(_fileName);
                    if (_fileName.isNotEmpty) {
                      _controller.text = _fileName;
                    }
                  });
                },
                child: Icon(FontAwesomeIcons.filePdf),
              ),
            ),
            FloatingActionButton.extended(
              label: Text('Upload'),
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.arrowCircleUp),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin:
                const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 40,
                  child: Text(
                    'Upload Assignment...',
                    style: ktitleStyle.copyWith(fontSize: 20),
                  ),
                ),
                TextField(
                    decoration: kTextFieldDecoration.copyWith(
                  hintText: string.title,
                  labelText: string.title,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  // color: Colors.blueAccent.withOpacity(0.5),
                  child: TextField(
                    // controller: _captionController,
                    // enabled: !isPosting,
                    maxLength: null,
                    onChanged: (description) {},
                    maxLines: 50,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: string.description_optional,
                      labelText: string.topic_description,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _controller,
                  enabled: false,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: string.file_name,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Subject',
                    labelText: 'Subject',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: string.standard,
                          labelText: string.standard,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: string.division,
                          hintText: string.division,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   Future buildShowDialogBox(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(string.upload_assignment),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: string.title,
//                   // hintStyle: TextStyle(fontFamily: "Nunito-Regular"),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: string.description_optional,
//                   // hintStyle: TextStyle(fontFamily: "Nunito-Regular"),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 controller: _controller,
//                 enabled: false,
//                 decoration: InputDecoration(
//                   hintText: string.file_name,
//                   // hintStyle: TextStyle(fontFamily: "Subtitle"),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             FlatButton(
//               onPressed: () async {
//                 _path = await openFileExplorer(FileType.ANY, mounted, context);
//                 setState(() {
//                   _fileName = _path != null ? _path.split('/').last : '...';
//                   print(_fileName);
//                   if (_fileName.isNotEmpty) {
//                     _controller.text = _fileName;
//                   }
//                 });
//               },
//               child: Icon(Icons.attach_file),
//             ),
//             FlatButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text(string.upload),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
