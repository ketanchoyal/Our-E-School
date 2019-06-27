import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/AnnouncementCard.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/core/Models/Announcement.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/core/enums/announcementType.dart';

import 'CreateAnnouncement.dart';

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
          title: string.announcement,
          child: kBackBtn,
          onPressed: () {
            kbackBtn(context);
          }),
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Visibility(
        visible: isTeacher,
        child: Visibility(
          visible: isTeacher,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  elevation: 12,
                  onPressed: () {
                    kopenPageBottom(context, CreateAnnouncement());
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.red,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 31),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    heroTag: 'abc',
                    elevation: 12,
                    onPressed: () {
                      //Filter Posts Code Here
                      filterDialogBox(context);
                    },
                    child: Icon(Icons.filter_list),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 700,
          ),
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => AnnouncementCard(
                  announcement: Announcement(
                      by: 'userid',
                      caption: randomText,
                      forClass: '10',
                      forDiv: 'A',
                      id: 'postid' +index.toString(),
                      photoUrl:
                          "https://cyprus-mail.com/wp-content/uploads/2013/06/schoolchildren06.jpg",
                      timestamp: 'Jan 21, 10:30 AM',
                      type: AnnouncementType.CIRCULAR),
                ),
          ),
        ),
      ),
    );
  }

  Future filterDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            string.show_announcement_of,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                string.filter_announcement,
                // style: TextStyle(fontFamily: 'Subtitle'),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  onChanged: (standard) {},
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  // decoration: InputDecoration(
                  //     hintText: "Master Pass",
                  //     hintStyle: TextStyle(fontFamily: "Subtitle"),
                  //     ),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: string.standard_hint,
                    labelText: string.standard,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  onChanged: (division) {},
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: string.division_hint,
                    labelText: string.division,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text(string.cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  child: Text(string.filter),
                  onPressed: () {},
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
