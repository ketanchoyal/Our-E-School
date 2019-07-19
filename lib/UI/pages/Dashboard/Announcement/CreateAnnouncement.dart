import 'dart:io';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourESchool/UI/pages/Dashboard/Announcement/camera_screen.dart';
import 'package:ourESchool/core/enums/announcementType.dart';

class CreateAnnouncement extends StatefulWidget {
  CreateAnnouncement({Key key}) : super(key: key);

  _CreateAnnouncementState createState() => _CreateAnnouncementState();
}

class _CreateAnnouncementState extends State<CreateAnnouncement> {
  String path = null;

  TextEditingController _standardController;
  TextEditingController _divisionController;
  TextEditingController _captionController;

  AnnouncementType announcementType = AnnouncementType.EVENT;

  FocusNode _focusNode = new FocusNode();
  GlobalKey _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _standardController = TextEditingController();
    _captionController = TextEditingController();
    _divisionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                          Expanded(
                            // width: MediaQuery.of(context).size.width / 2.2,
                            child: TextField(
                              controller: _standardController,
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
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            // width: MediaQuery.of(context).size.width / 2.2,
                            child: TextField(
                              controller: _divisionController,
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
                  height: 60,
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          child: Text(
                            'EVENT',
                            style: TextStyle(
                              color: announcementType == AnnouncementType.EVENT
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              announcementType = AnnouncementType.EVENT;
                            });
                          },
                          color: announcementType == AnnouncementType.EVENT
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          child: Text(
                            'CIRCULAR',
                            style: TextStyle(
                              color:
                                  announcementType == AnnouncementType.CIRCULAR
                                      ? Colors.white
                                      : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              announcementType = AnnouncementType.CIRCULAR;
                            });
                          },
                          color: announcementType == AnnouncementType.CIRCULAR
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          child: Text(
                            'ACTIVITY',
                            style: TextStyle(
                              color:
                                  announcementType == AnnouncementType.ACTIVITY
                                      ? Colors.white
                                      : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              announcementType = AnnouncementType.ACTIVITY;
                            });
                          },
                          color: announcementType == AnnouncementType.ACTIVITY
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                        ),
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
                              onPressed: () async {
                                final path = Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => CameraScreen()),
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
                                String _path = await openFileExplorer(
                                  FileType.IMAGE,
                                  mounted,
                                  context,
                                );

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
                                        setState(
                                          () {
                                            path = null;
                                          },
                                        );
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
