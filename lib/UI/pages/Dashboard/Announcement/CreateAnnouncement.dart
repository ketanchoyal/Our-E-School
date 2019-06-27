import 'dart:io';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'CapturePhoto.dart';

class CreateAnnouncement extends StatefulWidget {
  CreateAnnouncement({Key key}) : super(key: key);

  _CreateAnnouncementState createState() => _CreateAnnouncementState();
}

class _CreateAnnouncementState extends State<CreateAnnouncement> {
  String path = null;
  
//   Future _openFileExplorer(FileType _pickingType) async {
//   String _path = '';
//   if (_pickingType != FileType.CUSTOM) {
//     try {
//       _path = await FilePicker.getFilePath(type: _pickingType);
//     } on PlatformException catch (e) {
//       print("Unsupported operation" + e.toString());
//     }
//     if (!mounted) return '';

//     return _path;
//   }
// }

  FocusNode _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        onTitleTapped: () {},
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: string.create_post,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        child: Icon(Icons.check),
      ),
      body: InkWell(
        // splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          _focusNode.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          string.this_post_is_for,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: TextField(
                              onChanged: (standard) {},
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: string.standard_hint,
                                labelText: string.standard,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: TextField(
                              onChanged: (division) {},
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: string.division_hint,
                                labelText: string.division,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: 300, minHeight: 0),
                  child: path == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            MaterialButton(
                              height: 100,
                              minWidth: MediaQuery.of(context).size.width / 2.2,
                              child: Icon(FontAwesomeIcons.camera),
                              onPressed: () async {
                                final path = Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => CapturePhoto()),
                                );
                                path.then((path) {
                                  setState(() {
                                    this.path = path;
                                  });
                                  print('Path' + path);
                                });
                              },
                            ),
                            MaterialButton(
                              minWidth: MediaQuery.of(context).size.width / 2.2,
                              height: 100,
                              child: Icon(Icons.photo_library),
                              onPressed: () async {
                                
                                String _path = await openFileExplorer(FileType.IMAGE, mounted);
                                
                                setState(() {
                                  path = _path;
                                });
                              },
                            ),
                          ],
                        )
                      : Card(
                          elevation: 4,
                          child: Container(
                            // constraints:
                            //     BoxConstraints(maxHeight: 300, minHeight: 0),
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Image(
                                  fit: BoxFit.contain,
                                  image: FileImage(
                                    File(path),
                                  ),
                                ),
                                Positioned(
                                  right: -0,
                                  bottom: -0,
                                  child: Card(
                                    elevation: 10,
                                    shape: kCardCircularShape,
                                    child: MaterialButton(
                                      minWidth: 20,
                                      height: 10,
                                      onPressed: () {
                                        setState(() {
                                          path = null;
                                        });
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  // color: Colors.blueAccent.withOpacity(0.5),
                  child: TextField(
                    focusNode: _focusNode,
                    maxLength: null,
                    maxLines: 50,
                    onChanged: (stuff) {},
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: string.type_your_stuff_here,
                      labelText: string.caption,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
