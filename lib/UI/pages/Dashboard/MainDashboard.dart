import 'package:ourESchool/core/helpers/FirebaseAnalytics.dart';
import 'package:ourESchool/imports.dart';

class MainDashboard extends StatefulWidget with AnalyticsScreen {
  MainDashboard({Key key}) : super(key: key) {
    // setCurrentScreen();
  }
  static String pageName = string.dashboard;

  _MainDashboardState createState() => _MainDashboardState();

  @override
  String get screenName => 'ParentAndTeacher Dashboard';
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: [
                    ColumnReusableCardButton(
                      directionIconHeroTag: string.childrens,
                      height: 70,
                      tileColor: Colors.deepPurpleAccent,
                      label: string.childrens,
                      icon: FontAwesomeIcons.child,
                      onPressed: () {
                        kopenPage(context, ChildrensPage());
                      },
                    ),
                    Container(
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RowReusableCardButton(
                            tileColor: Colors.deepOrangeAccent,
                            label: string.e_card,
                            onPressed: () {
                              kopenPage(context, ECardPage());
                            },
                            icon: Icons.perm_contact_calendar,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RowReusableCardButton(
                            tileColor: null,
                            icon: Icons.av_timer,
                            label: string.timetable,
                            onPressed: () {
                              kopenPage(context, TimeTablePage());
                            },
                          ),
                        ],
                      ),
                    ),
                    ColumnReusableCardButton(
                      directionIconHeroTag: string.announcement,
                      height: 70,
                      tileColor: Colors.orangeAccent,
                      label: string.announcement,
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
                            label: string.holidays,
                            onPressed: () {
                              kopenPage(context, HolidayPage());
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RowReusableCardButton(
                            tileColor: Colors.lightGreen,
                            label: string.assignment,
                            onPressed: () {
                              kopenPage(context, AssignmentsPage());
                            },
                            icon: Icons.assignment,
                          ),
                        ],
                      ),
                    ),
                    ColumnReusableCardButton(
                      height: 70,
                      tileColor: Colors.grey,
                      label: string.transportation,
                      onPressed: () {
                        kopenPage(context, TransportationPage());
                      },
                      icon: FontAwesomeIcons.bus,
                    ),
                    SizedBox(
                      height: 105,
                      child: ListView(
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RowReusableCardButtonBanner(
                                paddingTop: 0,
                                tileColor: Colors.pinkAccent,
                                icon: FontAwesomeIcons.female,
                                label: string.parenting_guide,
                                onPressed: () {
                                  kopenPage(context, ParentingGuidePage());
                                },
                              ),
                              RowReusableCardButtonBanner(
                                paddingTop: 0,
                                tileColor: Colors.red,
                                icon: FontAwesomeIcons.medkit,
                                label: string.health_tips,
                                onPressed: () {},
                              ),
                              RowReusableCardButtonBanner(
                                paddingTop: 0,
                                tileColor: Colors.blue,
                                icon: FontAwesomeIcons.userMd,
                                label: string.vaccinations,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ColumnReusableCardButton(
                      tileColor: Colors.greenAccent,
                      height: 70,
                      label: string.offers,
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
      ),
    );
  }
}
