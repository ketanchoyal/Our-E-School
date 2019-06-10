import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/custom_icons.dart';
import 'package:acadamicConnect/pages/ProfilePage.dart';
import 'package:flutter/material.dart';

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
      body: Container(
        child: Column(
          children: <Widget>[
            Card(
              elevation: 4,
              // color: ThemeData().cardColor,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 100,
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    Icon(
                      CustomIcons.bullhorn,
                      size: 50,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
