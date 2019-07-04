import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:flutter/material.dart';

class FeesPage extends StatefulWidget {
  FeesPage({Key key}) : super(key: key);

  _FeesPageState createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: string.fees,
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Total Fees Due',
                  style: ktitleStyle,
                ),
              ),
              Center(
                child: Text(
                  'INR 21,000',
                  style: ktitleStyle.copyWith(
                    fontSize: 30,
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Total Fees Paid',
                  style: ktitleStyle,
                ),
              ),
              Center(
                child: Text(
                  'INR 10,000',
                  style: ktitleStyle.copyWith(
                    fontSize: 30,
                    color: Colors.green
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Stack(
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: TabBar(
                indicatorWeight: 4,
                controller: _tabController,
                indicatorColor: Theme.of(context).primaryColor,
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      string.fees_due,
                      style: ktitleStyle.copyWith(
                          color: Theme.of(context).textTheme.body1.color),
                    ),
                  ),
                  Tab(
                    child: Text(
                      string.fees_paid,
                      style: ktitleStyle.copyWith(
                          color: Theme.of(context).textTheme.body1.color),
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
