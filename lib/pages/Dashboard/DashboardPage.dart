import 'package:acadamicConnect/Components/ColumnReusableCardButton.dart';
import 'package:acadamicConnect/Components/RowReusableCardButton.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:acadamicConnect/Utility/custom_icons.dart';
import 'package:acadamicConnect/pages/Dashboard/QuizPage.dart';
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RowReusableCardButton(
                          tileColor: Colors.deepOrangeAccent,
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
                        SizedBox(width: 5,),
                        RowReusableCardButton(
                          tileColor: null,
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
                    tileColor: Colors.orangeAccent,
                    label: 'Announcements',
                    icon: CustomIcons.megaphone,
                    onPressed: () {
                      kopenPage(context, AnnouncementPage());
                    },
                  ),
                  Container(
                    height: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RowReusableCardButton(
                          tileColor: Colors.blueGrey,
                          icon: CustomIcons.traveler_with_a_suitcase,
                          label: 'Holidays',
                          onPressed: () {},
                        ),
                        SizedBox(width: 5,),
                        RowReusableCardButton(
                          tileColor: Colors.indigoAccent,
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
                    tileColor: Colors.lightGreen,
                    label: 'Assignments',
                    onPressed: () {
                      kopenPage(context, AssignmentsPage());
                    },
                    icon: Icons.assignment,
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView(
                      shrinkWrap: false,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RowReusableCardButtonBanner(
                              tileColor: Colors.red,
                              icon: Icons.assistant_photo,
                              label: 'Exams',
                              onPressed: () {
                                kopenPageBottom(context, QuizPage());
                              },
                            ),
                            RowReusableCardButtonBanner(
                              tileColor: Colors.tealAccent,
                              icon: FontAwesomeIcons.book,
                              label: 'E-Book',
                              onPressed: () {},
                            ),
                            RowReusableCardButtonBanner(
                              tileColor: Colors.deepPurpleAccent,
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
                            RowReusableCardButtonBanner(
                              tileColor: Colors.pinkAccent,
                              icon: FontAwesomeIcons.female,
                              label: 'Parenting Guide',
                              onPressed: () {
                                // kopenPage(context, ResultPage());
                              },
                            ),
                            RowReusableCardButtonBanner(
                              tileColor: Colors.black54,
                              icon: FontAwesomeIcons.medkit,
                              label: 'Health Tips',
                              onPressed: () {},
                            ),
                            RowReusableCardButtonBanner(
                              tileColor: Colors.blue,
                              icon: FontAwesomeIcons.userMd,
                              label: 'Vaccination',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ColumnReusableCardButton(
                    tileColor: Colors.greenAccent,
                    // height: 50,
                    label: 'Offers',
                    onPressed: () {},
                    icon: Icons.receipt,
                    directionIcon: Icons.chevron_right,
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
