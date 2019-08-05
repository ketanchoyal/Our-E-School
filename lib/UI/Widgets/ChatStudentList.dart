import 'package:flutter/material.dart';
import 'package:ourESchool/imports.dart';
import 'package:random_color/random_color.dart';

class ChatStudentListWidget extends StatefulWidget {
  // final Function onPressed;
  final String heroTag;
  final DocumentSnapshot snapshot;
  final StudentListPageModel model;

  ChatStudentListWidget({this.snapshot, this.heroTag, this.model});

  @override
  _ChatStudentListWidgetState createState() => _ChatStudentListWidgetState();
}

class _ChatStudentListWidgetState extends State<ChatStudentListWidget> {
  @override
  void initState() {
    super.initState();
    widget.model.getStudentConnectionsData(widget.snapshot);
  }

  Color color = RandomColor().randomColor(
    colorSaturation: ColorSaturation.mediumSaturation,
    colorBrightness: ColorBrightness.dark,
    colorHue: ColorHue.blue,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Hero(
        transitionOnUserGestures: true,
        tag: widget.heroTag,
        child: Container(
          color: color,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            height: 70,
            onPressed: () {
              kopenPage(
                context,
                StudentConnectionPage(
                  model: widget.model,
                  studentDocumenetSnapshotKey: widget.snapshot.documentID,
                  color: color,
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  CustomIcons.profile,
                  size: 45,
                  color: Colors.white,
                ),
                Text(
                  widget.model.studentListMap
                          .containsKey(widget.snapshot.documentID)
                      ? widget.model.studentListMap[widget.snapshot.documentID]
                          .displayName
                      : "loading...",
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 55,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
