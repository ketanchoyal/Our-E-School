import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/pages/Dashboard/Assignment/AssignmentImageViewer.dart';
import 'package:ourESchool/UI/pages/shared/PDFOpener.dart';
import 'package:ourESchool/core/Models/Assignment.dart';

class AssignmentDetailBottomSheet extends StatefulWidget {
  AssignmentDetailBottomSheet({this.assignment});
  final Assignment assignment;
  @override
  _AssignmentDetailBottomSheetState createState() =>
      _AssignmentDetailBottomSheetState();
}

class _AssignmentDetailBottomSheetState
    extends State<AssignmentDetailBottomSheet> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton.extended(
            isExtended: true,
            label: Text('Read'),
            onPressed: () async {
              if (widget.assignment.type == 'PDF') {
                kopenPage(
                  context,
                  PDFOpener(
                    url: widget.assignment.url,
                    title: widget.assignment.title,
                  ),
                );
              } else {
                kopenPage(
                  context,
                  AssignmentImageViewer(
                    assignment: widget.assignment,
                  ),
                );
              }
            },
            icon: Icon(FontAwesomeIcons.arrowCircleUp)),
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
                    widget.assignment.title,
                    style: ktitleStyle.copyWith(fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  // color: Colors.blueAccent.withOpacity(0.5),
                  child: TextField(
                    maxLength: null,
                    readOnly: true,
                    // enabled: false,
                    maxLines: 50,
                    controller:
                        TextEditingController(text: widget.assignment.details),
                    // expands: true,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: string.description_optional,
                      labelText: 'Description regarding the Assignment',
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
                  controller: TextEditingController(text: widget.assignment.by),
                  enabled: false,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: string.file_name,
                    labelText: 'Uploaded By',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  enabled: false,
                  controller:
                      TextEditingController(text: widget.assignment.subject),
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
                TextField(
                  enabled: false,
                  controller: TextEditingController(
                    text: DateFormat("MMM d, E").add_jm().format(DateTime.parse(
                        widget.assignment.timeStamp
                            .toDate()
                            .toLocal()
                            .toString())),
                  ),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Time',
                    labelText: 'Time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Expanded(
                //       child: TextField(
                //         controller: TextEditingController(text: widget.assignment.standard),
                //         keyboardType: TextInputType.number,
                //         decoration: kTextFieldDecoration.copyWith(
                //           hintText: string.standard,
                //           labelText: string.standard,
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 10,
                //     ),
                //     Expanded(
                //       child: TextField(
                //         controller: TextEditingController(text: widget.assignment.div),
                //         decoration: kTextFieldDecoration.copyWith(
                //           labelText: string.division,
                //           hintText: string.division,
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
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
