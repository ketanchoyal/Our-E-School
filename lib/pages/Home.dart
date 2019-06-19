import 'package:acadamicConnect/Components/BottomBar.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:acadamicConnect/Utility/custom_icons.dart';
import 'package:acadamicConnect/pages/SettingPage.dart';
import 'package:flutter/material.dart';
import 'Chat/ChatPage.dart';
import 'Dashboard/Announcement/CreateAnnouncement.dart';
import 'Dashboard/DashboardPage.dart';
import 'ProfilePage.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentIndex = 0;
  Color background = Colors.white;
  bool isTeacher = true;
  String pageName = 'Home';

  List<Widget> pages = [
    Dashboard(),
    ChatPage(),
    // NotificationPage(),
    SettingPage()
  ];

  floatingButtonVisibility() {
    //Function to check if user id teacher or not
    setState(() {
      isTeacher = true;
    });
  }

  @override
  void initState() {
    super.initState();
    // floatingButtonVisibility();
  }

  @override
  Widget build(BuildContext context) {
    // setTheme();
    return Container(
      child: Scaffold(
        appBar: TopBar(
          title: pageName,
          child: Image(
            height: 30,
            width: 30,
            image: NetworkImage(
              "https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png",
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProfilePage(),
              ),
            );
          },
        ),
        floatingActionButton: Visibility(
          visible: isTeacher,
          child: FloatingActionButton(
            onPressed: () {
              kopenPage(context, CreateAnnouncement());
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.red,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: buildBubbleBottomBar(),
        body: pages[currentIndex],
      ),
    );
  }

  BubbleBottomBar buildBubbleBottomBar() {
    return BubbleBottomBar(
      backgroundColor: Theme.of(context).canvasColor,
      opacity: .2,
      currentIndex: currentIndex,
      onTap: (v) {
        setState(() {
          if (v == 0) {
            pageName = Dashboard.pageName;
          } else if (v == 1) {
            pageName = ChatPage.pageName;
          } else if (v == 2) {
            pageName = SettingPage.pageName;
          }
          currentIndex = v;
        });
      },
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      elevation: 10,
      fabLocation: isTeacher ? BubbleBottomBarFabLocation.end : null, //new
      hasNotch: isTeacher, //new
      hasInk: true, //new, gives a cute ink effect
      inkColor: Colors.black12, //optional, uses theme color if not specified
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
          backgroundColor: Colors.red,
          icon: Icon(
            Icons.dashboard,
          ),
          activeIcon: Icon(
            Icons.dashboard,
            color: Colors.red,
          ),
          title: Text("Home"),
        ),
        BubbleBottomBarItem(
          backgroundColor: Colors.deepPurple,
          icon: Icon(
            CustomIcons.chat_bubble,
            // size: 25,
          ),
          activeIcon: Icon(
            CustomIcons.chat_bubble,
            color: Colors.deepPurple,
          ),
          title: Text("Chat"),
        ),
        // BubbleBottomBarItem(
        //   backgroundColor: Colors.indigo,
        //   icon: Icon(
        //     Icons.notifications,
        //   ),
        //   activeIcon: Icon(
        //     Icons.notifications,
        //     color: Colors.indigo,
        //   ),
        //   title: Text("Notifications"),
        // ),
        BubbleBottomBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(
              Icons.settings,
            ),
            activeIcon: Icon(
              Icons.settings,
              color: Colors.orange,
            ),
            title: Text("Setting"))
      ],
    );
  }
}
