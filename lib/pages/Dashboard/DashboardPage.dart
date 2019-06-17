import 'package:acadamicConnect/Components/ColumnReusableCardButton.dart';
import 'package:acadamicConnect/Components/RowReusableCardButton.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:acadamicConnect/Utility/custom_icons.dart';
import 'package:acadamicConnect/pages/Dashboard/ResultPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Announcement/AnnouncementPage.dart';
import 'Assignment/AssignmentPage.dart';
import 'E-CardPage.dart';
import 'TimeTable/TimeTablePage.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);
  static String pageName = 'Dashboard';

  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: [
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
                          onPressed: () {
                            kopenPage(context, TimeTablePage());
                          },
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
                          icon: CustomIcons.traveler_with_a_suitcase,
                          label: 'Holidays',
                          onPressed: () {},
                        ),
                        RowReusableCardButton(
                          icon: Icons.assessment,
                          label: 'Results',
                          onPressed: () {
                            kopenPage(context, ResultPage());
                          },
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
                  ColumnReusableCardButton(
                    height: 50,
                    label: 'Exclusive Features',
                    onPressed: null,
                    icon: null,
                    directionIcon: Icons.keyboard_arrow_down,
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView(
                      shrinkWrap: false,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RowReusableCardButton(
                              icon: Icons.assistant_photo,
                              label: 'Exams',
                              onPressed: () {},
                            ),
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView(
                      shrinkWrap: false,
                      // padding: EdgeInsets.only(left: 10, right: 10),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RowReusableCardButton(
                              icon: FontAwesomeIcons.female,
                              label: 'Parenting Guide',
                              onPressed: () {
                                // kopenPage(context, ResultPage());
                              },
                            ),
                            RowReusableCardButton(
                              icon: FontAwesomeIcons.medkit,
                              label: 'Health Tips',
                              onPressed: () {},
                            ),
                            RowReusableCardButton(
                              icon: FontAwesomeIcons.userMd,
                              label: 'Vaccination',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
