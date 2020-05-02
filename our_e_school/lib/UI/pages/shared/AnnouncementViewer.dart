import 'package:intl/intl.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/swipedetector.dart';
import 'package:ourESchool/core/Models/Announcement.dart';
import 'package:flutter/material.dart';

class AnnouncementViewer extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementViewer({Key key, this.announcement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipeDown: () {
        Navigator.pop(context);
      },
      onSwipeRight: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        body: Container(
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Hero(
                      transitionOnUserGestures: true,
                      tag: announcement.id + 'photo',
                      child: Image(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          announcement.photoUrl,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        transitionOnUserGestures: false,
                        tag: announcement.id + 'roww',
                        child: Row(
                          children: <Widget>[
                            //User profile image section
                            CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(
                                'https://www.searchpng.com/wp-content/uploads/2019/02/Deafult-Profile-Pitcher.png',
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
                                  announcement.by,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                //TimeStamp section
                                Text(
                                  DateFormat("MMM d, E").add_jm().format(
                                      DateTime.parse(announcement.timestamp
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
                    ),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 5.0, top: 5),
                          child: Hero(
                            transitionOnUserGestures: false,
                            tag: announcement.id + 'captionn',
                            child: Text(
                              announcement.caption,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: -0,
                  top: -0,
                  child: Card(
                    elevation: 10,
                    shape: kCardCircularShape,
                    child: MaterialButton(
                      minWidth: 20,
                      height: 10,
                      onPressed: () {
                        Navigator.pop(context);
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
    );
  }
}
