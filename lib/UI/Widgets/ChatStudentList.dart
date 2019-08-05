import 'package:flutter/material.dart';
import 'package:ourESchool/imports.dart';
import 'package:random_color/random_color.dart';

class ChatStudentListWidget extends StatefulWidget {
  final Function onPressed;
  final String heroTag;
  final DocumentSnapshot snapshot;
  final StudentListPageModel model;

  ChatStudentListWidget(
      {this.snapshot, @required this.onPressed, this.heroTag, this.model});

  @override
  _ChatStudentListWidgetState createState() => _ChatStudentListWidgetState();
}

class _ChatStudentListWidgetState extends State<ChatStudentListWidget> {
  @override
  void initState() {
    super.initState();
    widget.model.getStudentConnectionsData(widget.snapshot);
  }

  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        color: _randomColor.randomColor(
          colorSaturation: ColorSaturation.mediumSaturation,
          colorBrightness: ColorBrightness.dark,
          colorHue: ColorHue.blue,
        ),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          height: 70,
          onPressed: widget.onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Hero(
                tag: widget.heroTag,
                child: Icon(
                  CustomIcons.profile,
                  size: 45,
                  color: Colors.white,
                ),
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
    );
  }
}
