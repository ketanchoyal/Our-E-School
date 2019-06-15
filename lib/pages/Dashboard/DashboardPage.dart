import 'package:acadamicConnect/Components/ColumnReusableCardButton.dart';
import 'package:acadamicConnect/Components/RowReusableCardButton.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:acadamicConnect/Utility/custom_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Announcement/AnnouncementPage.dart';
import 'Assignment/AssignmentPage.dart';
import 'E-CardPage.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);
  static String pageName = 'Dashboard';

  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.start,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RowReusableCardButton(
                      label: 'E-Card',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ECardPage(),
                          ),
                        );
                      },
                      icon: Icons.perm_contact_calendar,
                    ),
                    RowReusableCardButton(
                      icon: Icons.av_timer,
                      label: 'Time Table',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              ColumnReusableCardButton(
                label: 'Announcements',
                icon: CustomIcons.megaphone,
                onPressed: () {
                  kopenPage(context, AnnouncementPage());
                },
              ),
              Container(
                height: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RowReusableCardButton(
                      icon: FontAwesomeIcons.book,
                      label: 'E-Book',
                      onPressed: () {},
                    ),
                    RowReusableCardButton(
                      icon: FontAwesomeIcons.cameraRetro,
                      label: 'Video',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              ColumnReusableCardButton(
                label: 'Assignments',
                onPressed: () {
                  kopenPage(context, AssignmentsPage());
                },
                icon: Icons.assignment,
              ),
              Container(
                height: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RowReusableCardButton(
                      icon: Icons.assistant_photo,
                      label: 'Exams',
                      onPressed: () {},
                    ),
                    RowReusableCardButton(
                      icon: Icons.assessment,
                      label: 'Results',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              ColumnReusableCardButton(
                icon: CustomIcons.traveler_with_a_suitcase,
                label: 'Holidays',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
