import 'package:flutter/scheduler.dart';
import 'package:ourESchool/imports.dart';

class ChatTeachersListWidget extends StatefulWidget {
  // final Function onPressed;
  final String heroTag;
  final DocumentSnapshot snapshot;
  final ChatUsersListPageModel model;

  ChatTeachersListWidget({this.snapshot, this.heroTag, this.model});

  @override
  _ChatTeachersListWidgetState createState() => _ChatTeachersListWidgetState();

  // void onLoad()
}

class _ChatTeachersListWidgetState extends State<ChatTeachersListWidget> {
  @override
  void initState() {
    super.initState();
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback(
          (_) => widget.model.getSingleTeacherData(widget.snapshot));
    }
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
          height: 70,
          color: color,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              // kopenPage(
              //   context,
              //   StudentConnectionPage(
              //     model: widget.model,
              //     studentDocumenetSnapshotKey: widget.snapshot.documentID,
              //     color: color,
              //   ),
              // );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.peopleCarry,
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
