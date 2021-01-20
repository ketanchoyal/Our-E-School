import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/pages/BaseView.dart';
import 'package:ourESchool/core/Models/Assignment.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/viewmodel/AssignmentPageModel.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:provider/provider.dart';

class AssignmentBottomSheet extends StatefulWidget {
  AssignmentBottomSheet();
  @override
  _AssignmentBottomSheetState createState() => _AssignmentBottomSheetState();
}

class _AssignmentBottomSheetState extends State<AssignmentBottomSheet> {
  TextEditingController _fileNamecontroller = TextEditingController();

  String _fileName;
  String _path = null;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _standardController = TextEditingController();
  TextEditingController _divisionController = TextEditingController();

  _uploadButtonPressed(var model) async {
    if (_path != null &&
        _titleController.text.trim() != '' &&
        _descriptionController.text.trim() != '' &&
        _divisionController.text.trim() != '' &&
        _standardController.text.trim() != '' &&
        _standardController.text.trim() != '') {
      Assignment assignment = Assignment(
        title: _titleController.text.trim(),
        by: Provider.of<AppUser>(context, listen: false).id,
        details: _descriptionController.text.trim(),
        div: _divisionController.text.trim().toUpperCase(),
        standard: _standardController.text.trim(),
        url: _path,
        subject: _subjectController.text.trim(),
      );

      await model.addAssignment(assignment);

      Navigator.pop(context);
    } else {
      _scaffoldKey.currentState.showSnackBar(
        ksnackBar(context, 'All the fields are mandatory...'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AssignmentPageModel>(builder: (context, model, child) {
      return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 31),
                child: Row(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () async {
                        _path = await openFileExplorer(
                            FileType.custom, mounted, context,
                            ext: 'PDF');
                        setState(() {
                          _fileName =
                              _path != null ? _path.split('/').last : '...';
                          print(_fileName);
                          if (_fileName.isNotEmpty) {
                            _fileNamecontroller.text = _fileName;
                          }
                        });
                      },
                      child: Icon(FontAwesomeIcons.filePdf),
                    ),
                    Text(
                      ' OR ',
                      style: ktitleStyle,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        _path = await openFileExplorer(
                            FileType.image, mounted, context,
                            ext: 'NOCOMPRESSION');
                        setState(() {
                          _fileName =
                              _path != null ? _path.split('/').last : '...';
                          print(_fileName);
                          if (_fileName.isNotEmpty) {
                            _fileNamecontroller.text = _fileName;
                          }
                        });
                      },
                      child: Icon(FontAwesomeIcons.fileImage),
                    ),
                  ],
                ),
              ),
              FloatingActionButton.extended(
                isExtended: model.state == ViewState.Idle ? true : false,
                label: model.state == ViewState.Idle
                    ? Text('Upload')
                    : Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: SpinKitDoubleBounce(
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                onPressed: () async {
                  if (model.state == ViewState.Idle)
                    await _uploadButtonPressed(model);
                },
                icon: model.state == ViewState.Idle
                    ? Icon(FontAwesomeIcons.arrowCircleUp)
                    : Container(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                  top: 40, left: 10, right: 10, bottom: 10),
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
                      controller: _titleController,
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
                      controller: _descriptionController,
                      autocorrect: true,
                      maxLength: null,
                      maxLines: 30,
                      // expands: true,
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
                    controller: _fileNamecontroller,
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
                    controller: _subjectController,
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
                          controller: _standardController,
                          keyboardType: TextInputType.number,
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
                          controller: _divisionController,
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
    });
  }
}
