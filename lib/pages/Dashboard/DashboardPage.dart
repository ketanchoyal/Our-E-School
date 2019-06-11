import 'package:acadamicConnect/Components/ColumnReusableCardButton.dart';
import 'package:acadamicConnect/Components/RowReusableCardButton.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:acadamicConnect/Utility/custom_icons.dart';
import 'package:acadamicConnect/pages/Dashboard/AnnouncementPage.dart';
import 'package:acadamicConnect/pages/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Assignment/AssignmentPage.dart';
import 'E-CardPage.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Dashboard',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ProfilePage(),
            ),
          );
        },
        child: Image(
          height: 30,
          width: 30,
          image: NetworkImage(
            "https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 120,
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
                      icon: Icons.assessment,
                      label: 'Results',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              ColumnReusableCardButton(
                label: 'Announcements',
                icon: CustomIcons.megaphone,
                onPressed: () {
                  openPage(context, AnnouncementPage());
                },
              ),
              ColumnReusableCardButton(
                label: 'Assignments',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AssignmentsPage(),
                    ),
                  );
                },
                icon: Icons.assignment,
              ),
              ColumnReusableCardButton(
                icon: CustomIcons.traveler_with_a_suitcase,
                label: 'Holidays',
                onPressed: () {},
              ),
              Container(
                height: 120,
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
            ],
          ),
        ),
      ),
    );
  }
}
