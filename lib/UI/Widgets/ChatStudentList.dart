import 'package:flutter/scheduler.dart';
import 'package:ourESchool/imports.dart';

class ChatStudentListWidget extends StatefulWidget {
  // final Function onPressed;
  final String heroTag;
  final DocumentSnapshot snapshot;
  final ChatUsersListPageModel model;

  ChatStudentListWidget({this.snapshot, this.heroTag, this.model});

  @override
  _ChatStudentListWidgetState createState() => _ChatStudentListWidgetState();

  // void onLoad()
}

class _ChatStudentListWidgetState extends State<ChatStudentListWidget> {
  @override
  void initState() {
    super.initState();
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback(
          (_) => widget.model.getSingleStudentData(widget.snapshot));
    }
  }

  Color color(var context) => Theme.of(context).textTheme.body1.color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Hero(
        transitionOnUserGestures: true,
        tag: widget.heroTag,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            border: Border(
              top: BorderSide(width: 1, color: color(context)),
              bottom: BorderSide(width: 1, color: color(context)),
              left: BorderSide(width: 1, color: color(context)),
              right: BorderSide(width: 1, color: color(context)),
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.zero,
                topRight: Radius.zero),
          ),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              kopenPage(
                context,
                StudentConnectionPage(
                  model: widget.model,
                  documentSnapshot: widget.snapshot,
                  // color: color,
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  assetsString.student_welcome,
                  height: 50,
                  width: 50,
                ),
                Text(
                  widget.model.studentListMap.containsKey(widget.snapshot.id)
                      ? widget
                          .model.studentListMap[widget.snapshot.id].displayName
                      : "loading...",
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 22,
                      // color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                Icon(
                  Icons.chevron_right,
                  // color: Colors.white,
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
