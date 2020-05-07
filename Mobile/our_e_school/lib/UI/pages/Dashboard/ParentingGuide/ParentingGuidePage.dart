import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/AnnouncementCard.dart';
import 'package:ourESchool/UI/Widgets/ParentingGuideCard.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/core/Models/Announcement.dart';
import 'package:flutter/material.dart';

class ParentingGuidePage extends StatefulWidget {
  ParentingGuidePage({Key key}) : super(key: key);

  _ParentingGuidePageState createState() => _ParentingGuidePageState();
}

class _ParentingGuidePageState extends State<ParentingGuidePage> {
  String randomText =
      '''When using any kind of state management strategy how should I handle exceptions?
I’m confused if they’re business logic or UI logic.
For example:
I want to perform login and call a function for that, this function can either return a token or raise an exception, depending on the case my UI will display different information. Should I handle the exception in my business logic and convert it to a state or should I handle it in the UI?''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: string.parenting_guide,
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 700,
          ),
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              var announcement2 = Announcement(
                  by: 'userid',
                  caption: randomText + randomText + randomText,
                  forClass: '10A',
                  id: 'postid' + index.toString(),
                  photoUrl:
                      "https://cyprus-mail.com/wp-content/uploads/2013/06/schoolchildren06.jpg",
                  timestamp: Timestamp.now()
                  // timestamp: 'Jan 21, 10:30 AM',
                  );
              return ParentingGuideCard(
                announcement: announcement2,
              );
            },
          ),
        ),
      ),
    );
  }
}
