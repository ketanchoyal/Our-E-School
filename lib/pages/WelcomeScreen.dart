import 'package:acadamicConnect/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:acadamicConnect/Utility/constants.dart';

class WelcomeScreen extends StatelessWidget {
  List<PageViewModel> page(BuildContext context) {
    return [
      PageViewModel(
        iconColor: kmainColorTeacher,
        iconImageAssetPath: 'assets/key.png',
        pageColor: kmainColorTeacher,
        // bubbleBackgroundColor: Colors.white,
        title: Container(),
        body: Column(
          children: <Widget>[
            Text(
              'Teachers',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
            ),
            Text(
              'Create posts, and notify your students and there parents to keep them updated',
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        mainImage: Image.asset(
          'assets/teacher.png',
          // fit: BoxFit.none,
          width: MediaQuery.of(context).size.width - 60,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(color: Colors.white),
      ),
      PageViewModel(
        iconColor: kmainColorStudents,
        iconImageAssetPath: 'assets/key.png',
        pageColor: kmainColorStudents,
        // bubbleBackgroundColor: Colors.white,
        title: Container(),
        body: Column(
          children: <Widget>[
            Text(
              'Students',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
            ),
            Text(
              '''Check School posts to stay updated with school news.
Take quizzes, test at home all through your phone''',
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        mainImage: Image.asset(
          'assets/students.png',
          // fit: BoxFit.none,
          width: MediaQuery.of(context).size.width - 60,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(color: Colors.white),
      ),
      PageViewModel(
        iconColor: kmainColorParents,
        iconImageAssetPath: 'assets/key.png',
        pageColor: kmainColorParents,
        // bubbleBackgroundColor: Colors.white,
        title: Container(),
        body: Column(
          children: <Widget>[
            Text(
              'Parents',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
            ),
            Text(
              '''Stay in touch with your kid\'s teachers.
Check School posts to stay updated with school news.''',
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        mainImage: Image.asset(
          'assets/parent2.png',
          // fit: BoxFit.none,
          width: MediaQuery.of(context).size.width - 60,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(color: Colors.white),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          IntroViewsFlutter(
            page(context),
            onTapDoneButton: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage(),
                ),
              );
            },
            showNextButton: true,
            showBackButton: true,
            skipText: Text(
              '↠',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            backText: Text(
              '←',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            nextText: Text(
              '→',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            showSkipButton: true,
            doneText: Container(),
            pageButtonsColor: Color.fromARGB(100, 254, 198, 27),
            pageButtonTextStyles: new TextStyle(
              color: Colors.indigo,
              fontSize: 16.0,
              fontFamily: "Regular",
            ),
          ),
          Positioned(
            bottom: 60.0,
            width: MediaQuery.of(context).size.width,
            // left: MediaQuery.of(context).size.width/2 - 40,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Hero(
                tag: 'title',
                transitionOnUserGestures: true,
                child: MaterialButton(
                  height: 50,
                  minWidth: 300,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      // bottomRight: Radius.elliptical(40, 1),
                      topRight: Radius.circular(1000),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                    );
                  },
                  color: Colors.white,
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: kmainColorTeacher,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            width: MediaQuery.of(context).size.width,
            // left: MediaQuery.of(context).size.width/2 - 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
