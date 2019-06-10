import 'package:acadamicConnect/Components/ColumnReusableCardButton.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/custom_icons.dart';
import 'package:acadamicConnect/pages/MessagingScreen.dart';
import 'package:flutter/material.dart';
import 'ProfilePage.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Chat',
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
              ColumnReusableCardButton(
                label: 'Teacher 1',
                icon: CustomIcons.profile,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MessagingScreen(),
                    ),
                  );
                },
                height: 70,
              ),
              ColumnReusableCardButton(
                label: 'Teacher 2',
                onPressed: () {},
                icon: CustomIcons.profile,
                height: 70,
              ),
              ColumnReusableCardButton(
                icon: CustomIcons.profile,
                label: 'Teacher 3',
                onPressed: () {},
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
