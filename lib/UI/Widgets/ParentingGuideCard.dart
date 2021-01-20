import 'package:intl/intl.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/pages/shared/AnnouncementViewer.dart';
import 'package:ourESchool/core/Models/Announcement.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/viewmodel/ProfilePageModel.dart';
import 'package:ourESchool/locator.dart';

class ParentingGuideCard extends StatefulWidget {
  ParentingGuideCard({@required this.announcement});

  final Announcement announcement;

  @override
  _ParentingGuideCardState createState() => _ParentingGuideCardState();
}

class _ParentingGuideCardState extends State<ParentingGuideCard> {
  final ProfilePageModel model = locator<ProfilePageModel>();

  AppUser user = AppUser();

  getUserData() async {
    // user = await model.getUserProfileDatabyId(
    //     UserType.TEACHER, widget.announcement.by);
    // if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Card(
        elevation: 4,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              // color: Colors.red[200],
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Hero(
                    transitionOnUserGestures: false,
                    tag: widget.announcement.id + 'row',
                    child: Row(
                      children: <Widget>[
                        //User profile image section
                        model.state == ViewState.Busy
                            ? CircleAvatar(
                                radius: 25.0,
                                backgroundImage:
                                    AssetImage(assetsString.teacher_welcome),
                                backgroundColor: Colors.transparent,
                              )
                            : CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                  user.photoUrl == 'default'
                                      ? 'https://www.searchpng.com/wp-content/uploads/2019/02/Deafult-Profile-Pitcher.png'
                                      : user.photoUrl,
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //Announcement by section
                            Text(
                              model.state == ViewState.Busy
                                  ? 'Loading...'
                                  : user.displayName,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            //TimeStamp section
                            Text(
                              // 'data',
                              DateFormat("MMM d, E").add_jm().format(
                                  DateTime.parse(widget.announcement.timestamp
                                      .toDate()
                                      .toLocal()
                                      .toString())),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //Announcement Type section
                  Visibility(
                    visible: widget.announcement.type == null ? false : true,
                    child: InkWell(
                      onTap: () {
                        print(widget.announcement.timestamp.toString());
                        buildShowDialogBox(context);
                      },
                      child: Card(
                        shape: kCardCircularShape,
                        // color: Colors.redAccent,
                        elevation: 4,
                        child: CircleAvatar(
                          backgroundColor: ThemeData().canvasColor,
                          child: Text(
                            widget.announcement.type
                                .toString()
                                .substring(widget.announcement.type
                                        .toString()
                                        .indexOf('.') +
                                    1)
                                .substring(0, 1),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //Announcemnet image Section
            Card(
              elevation: 4,
              child: Container(
                constraints: BoxConstraints(maxHeight: 300, minHeight: 0),
                width: MediaQuery.of(context).size.width,
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: widget.announcement.id + 'photo',
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        kopenPageBottom(
                          context,
                          AnnouncementViewer(
                            announcement: widget.announcement,
                          ),
                        );
                      },
                      child: widget.announcement.photoUrl == ''
                          ? Container(
                              height: 0,
                            )
                          : Image(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                widget.announcement.photoUrl,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            //Caption Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: BoxConstraints(maxHeight: 80, minHeight: 10),
                width: MediaQuery.of(context).size.width,
                child: Hero(
                  transitionOnUserGestures: false,
                  tag: widget.announcement.id + 'caption',
                  child: Text(
                    widget.announcement.caption,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future buildShowDialogBox(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Announcement Type"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Card(
                  shape: kCardCircularShape,
                  elevation: 4,
                  child: CircleAvatar(
                    backgroundColor: ThemeData().canvasColor,
                    child: Text(
                      'C',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Text('CIRCULAR')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  shape: kCardCircularShape,
                  elevation: 4,
                  child: CircleAvatar(
                    backgroundColor: ThemeData().canvasColor,
                    child: Text(
                      'E',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Text('EVENT')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Card(
                  shape: kCardCircularShape,
                  elevation: 4,
                  child: CircleAvatar(
                    backgroundColor: ThemeData().canvasColor,
                    child: Text(
                      'A',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Text('ACTIVITY')
              ],
            ),
          ],
        ),
        actions: <Widget>[],
      );
    },
  );
}
