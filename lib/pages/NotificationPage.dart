import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:flutter/material.dart';
import 'Profiles/ProfilePage.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: TopBar(
           title: 'Notifications',
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
       ),
    );
  }
}