import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Utility/custom_icons.dart';
import 'package:ourESchool/UI/Widgets/BottomBar.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/UI/pages/Profiles/GuardianProfile.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:provider/provider.dart';
import 'Chat/ChatPage.dart';
import 'Dashboard/Announcement/CreateAnnouncement.dart';
import 'Dashboard/MainDashboard.dart';
import 'Dashboard/StudentDashboard.dart';
import 'Profiles/ProfilePage.dart';
import 'Setting/SettingPage.dart';

class Home extends StatefulWidget {
  static const id = 'Home';
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentIndex = 0;
  Color background = Colors.white;
  // AuthenticationServices _auth = locator<AuthenticationServices>();
  bool isTeacher = false;
  // MainPageModel mainPageModel;

  // _auth.userType == UserType.STUDENT ? false : true;
  String pageName = string.home;

  List<Widget> pages = [
    MainDashboard(),
    ChatPage(),
    // NotificationPage(),
    SettingPage()
  ];

  List<Widget> pages2 = [
    StudentDashboard(),
    // ChatPage(),
    // NotificationPage(),
    SettingPage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userType = Provider.of<UserType>(context);
    if (userType == UserType.TEACHER) {
      isTeacher = true;
    }
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
            if (userType == UserType.PARENT) {
              kopenPage(context, GuardianProfilePage());
            } else {
              kopenPage(context, ProfilePage());
            }
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
        bottomNavigationBar: buildBubbleBottomBar(userType),
        body: userType == UserType.STUDENT
            ? pages2[currentIndex]
            : pages[currentIndex],
      ),
    );
  }

  List<BubbleBottomBarItem> bottomBarItems2 = [
    BubbleBottomBarItem(
      backgroundColor: Colors.red,
      icon: Icon(
        Icons.dashboard,
      ),
      activeIcon: Icon(
        Icons.dashboard,
        color: Colors.red,
      ),
      title: Text(string.dashboard),
    ),
    // BubbleBottomBarItem(
    //   backgroundColor: Colors.deepPurple,
    //   icon: Icon(
    //     CustomIcons.chat_bubble,
    //     // size: 25,
    //   ),
    //   activeIcon: Icon(
    //     CustomIcons.chat_bubble,
    //     color: Colors.deepPurple,
    //   ),
    //   title: Text(string.chat),
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
      title: Text(
        string.setting,
      ),
    )
  ];

  List<BubbleBottomBarItem> bottomBarItems = [
    BubbleBottomBarItem(
      backgroundColor: Colors.red,
      icon: Icon(
        Icons.dashboard,
      ),
      activeIcon: Icon(
        Icons.dashboard,
        color: Colors.red,
      ),
      title: Text(string.dashboard),
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
      title: Text(string.chat),
    ),
    BubbleBottomBarItem(
      backgroundColor: Colors.orange,
      icon: Icon(
        Icons.settings,
      ),
      activeIcon: Icon(
        Icons.settings,
        color: Colors.orange,
      ),
      title: Text(
        string.setting,
      ),
    )
  ];

  BubbleBottomBar buildBubbleBottomBar(UserType userType) {
    return BubbleBottomBar(
      backgroundColor: Theme.of(context).canvasColor,
      opacity: .2,
      currentIndex: currentIndex,
      onTap: (v) {
        if (userType == UserType.STUDENT) {
          setState(() {
            if (v == 0) {
              pageName = StudentDashboard.pageName;
            } else {
              pageName = SettingPage.pageName;
            }
            currentIndex = v;
          });
        } else {
          setState(() {
            if (v == 0) {
              pageName = MainDashboard.pageName;
            } else if (v == 1) {
              pageName = ChatPage.pageName;
            } else if (v == 2) {
              pageName = SettingPage.pageName;
            }
            currentIndex = v;
          });
        }
      },
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      elevation: 10,
      fabLocation: isTeacher ? BubbleBottomBarFabLocation.end : null, //new
      hasNotch: isTeacher, //new
      hasInk: true, //new, gives a cute ink effect
      inkColor: Colors.black12, //optional, uses theme color if not specified
      items: userType == UserType.STUDENT ? bottomBarItems2 : bottomBarItems,
    );
  }
}
