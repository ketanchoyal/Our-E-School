import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/Resources.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:acadamicConnect/pages/Dashboard/TimeTable/TimeTable.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, initialIndex: 0, length: tabNames.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: string.timetable,
        child: kBackBtn,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(tabNames.length, (index) => TimeTable())
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          // Container(
          //   height: 20,
          //   color: Theme.of(context).primaryColor,
          // )
        ],
      ),
    );
  }
}
