import 'package:acadamicConnect/Models/Announcement.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({@required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Card(
        elevation: 4,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              // color: Colors.red[200],
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
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
                            announcement.timestamp,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //Announcement Type section
                  InkWell(
                    onTap: () {
                      buildShowDialogBox(context);
                    },
                    child: Card(
                      shape: kCardCircularShape,
                      // color: Colors.redAccent,
                      elevation: 4,
                      child: CircleAvatar(
                        backgroundColor: ThemeData().canvasColor,
                        child: Text(
                          announcement.type
                              .toString()
                              .substring(
                                  announcement.type.toString().indexOf('.') + 1)
                              .substring(0, 1),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
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
                child: announcement.photoUrl == null
                    ? Container(
                        height: 0,
                      )
                    : Image(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          announcement.photoUrl,
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
                child: Text(
                  announcement.caption,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(fontWeight: FontWeight.w400),
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
