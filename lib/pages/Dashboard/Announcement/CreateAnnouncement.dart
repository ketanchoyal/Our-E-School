import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';

class CreateAnnouncement extends StatefulWidget {
  CreateAnnouncement({Key key}) : super(key: key);

  _CreateAnnouncementState createState() => _CreateAnnouncementState();
}

class _CreateAnnouncementState extends State<CreateAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: 'Create Post',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'This Post is for:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: TextField(
                        onChanged: (standard) {},
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: '9/10/11',
                          labelText: 'Class',
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: TextField(
                        onChanged: (division) {},
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'A/B/C',
                          labelText: 'Division',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            color: Colors.amber,
          ),
          Container(
            height: 150,
            color: Colors.blueAccent.withOpacity(0.5),
          )
        ],
      ),
    );
  }
}
