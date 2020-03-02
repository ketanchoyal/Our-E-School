import 'package:ourESchool/UI/pages/Dashboard/TimeTable/TeachersTimeTable.dart';
import 'package:ourESchool/imports.dart';
import 'StudentsTimeTable.dart';

class TimeTablePage extends StatefulWidget {
  TimeTablePage({Key key}) : super(key: key);

  _TimeTablePageState createState() => _TimeTablePageState();
}

const List<String> tabNames = const <String>[
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thrusday',
  'Friday',
  'Saturday'
];

class _TimeTablePageState extends State<TimeTablePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  Color color = Colors.red;
  bool teacher = true;
  bool edit = false;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, initialIndex: 0, length: tabNames.length);
  }

  @override
  Widget build(BuildContext context) {
    UserType userType = Provider.of<UserType>(context, listen: false);
    return Scaffold(
      appBar: TopBar(
        title: string.timetable,
        child: kBackBtn,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: userType == UserType.TEACHER
          ? FloatingActionButton(
              onPressed: () {
                edit = !edit;
                setState(() {});
              },
              child: Icon(
                !edit ? FontAwesomeIcons.solidEdit : FontAwesomeIcons.save,
                size: 20,
              ),
              backgroundColor: Colors.red,
            )
          : Container(),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          tabNames.length,
          (index) => teacher
              ? TeachersTimeTable(
                  color: color,
                  edit: edit,
                )
              : StudentsTimeTable(
                  color: color,
                  edit: edit,
                ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          userType == UserType.TEACHER
              ? Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          teacher = true;
                          setState(() {});
                        },
                        child: Container(
                          height: 50,
                          color: teacher ? color : Colors.white,
                          child: Center(
                            child: Text(
                              'Teachers',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: !teacher ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          teacher = false;
                          setState(() {});
                        },
                        child: Container(
                          height: 50,
                          color: !teacher ? color : Colors.white,
                          child: Center(
                            child: Text(
                              'Students',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: teacher ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          AnimatedCrossFade(
            firstChild: Material(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                indicatorColor: Colors.white,
                controller: _tabController,
                isScrollable: true,
                tabs: List.generate(tabNames.length, (index) {
                  return Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        tabNames[index].toUpperCase(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                }),
              ),
            ),
            secondChild: Container(),
            crossFadeState: CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
