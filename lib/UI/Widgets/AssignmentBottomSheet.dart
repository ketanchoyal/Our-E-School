import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/core/viewmodel/AssignmentPageModel.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';

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