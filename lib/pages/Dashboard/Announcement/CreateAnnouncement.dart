import 'dart:io';

import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateAnnouncement extends StatefulWidget {
  CreateAnnouncement({Key key}) : super(key: key);

  _CreateAnnouncementState createState() => _CreateAnnouncementState();
}

class _CreateAnnouncementState extends State<CreateAnnouncement> {
  String path = null;

  _openFileExplorer(FileType _pickingType) async {
    String _path = null;
    if (_pickingType != FileType.CUSTOM) {
      try {
        _path = await FilePicker.getFilePath(type: _pickingType);
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;

      setState(() {
        path = _path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: 'Create Post',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        child: Icon(Icons.check),
      ),
      body: Padding(
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
                      'This Post is for:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: TextField(
                          onChanged: (standard) {},
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: '9/10/11',
                            labelText: 'Class',
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
                            hintText: 'A/B/C',
                            labelText: 'Division',
                          ),
                        ),
                      ),
                    ],
                  )
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
                          onPressed: () {},
                        ),
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width / 2.2,
                          height: 100,
                          child: Icon(Icons.photo_library),
                          onPressed: () {
                            _openFileExplorer(FileType.IMAGE);
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
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(path),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Card(
                                shape: kCardCircularShape,
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      path = null;
                                    });
                                  },
                                  child: Icon(
                                    Icons.close,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            Container(
              height: 150,
              // color: Colors.blueAccent.withOpacity(0.5),
              child: TextField(
                maxLength: null,
                maxLines: 50,
                onChanged: (division) {},
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Type your stuff here.....',
                  labelText: 'Caption',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
