import 'package:acadamicConnect/Components/AnnouncementCard.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Models/Announcement.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key key}) : super(key: key);

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  bool isTeacher = true;

  String url =
      'https://i1.rgstatic.net/publication/274400281_Adult_male_circumcision_with_a_circular_stapler_versus_conventional_circumcision_A_prospective_randomized_clinical_trial/links/5599d54708ae793d13805d4f/largepreview.png';

  String randomText =
      '''When using any kind of state management strategy how should I handle exceptions?
I’m confused if they’re business logic or UI logic.
For example:
I want to perform login and call a function for that, this function can either return a token or raise an exception, depending on the case my UI will display different information. Should I handle the exception in my business logic and convert it to a state or should I handle it in the UI?''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Announcement',
        child: kBackBtn,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Visibility(
        visible: isTeacher,
        child: FloatingActionButton(
          elevation: 12,
          onPressed: () {},
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => new AnnouncementCard(
              announcement: Announcement(
                by: 'userid',
                caption: randomText,
                forClass: '10A',
                id: 'postid',
                photoUrl: "https://cyprus-mail.com/wp-content/uploads/2013/06/schoolchildren06.jpg",
                timestamp: 'Jan 21, 10:30 AM',
                type: AnnouncementType.CIRCULAR
              ),
            ),
      ),
    );
  }
}
