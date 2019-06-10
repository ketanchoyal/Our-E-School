import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ProfilePage.dart';

class ECardPage extends StatefulWidget {
  const ECardPage({Key key}) : super(key: key);

  @override
  _ECardPageState createState() => _ECardPageState();
}

class _ECardPageState extends State<ECardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: TopBar(
          title: 'E-Card',
          child: kBackBtn,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Container(
                  width: 160.0,
                  height: 160.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png"),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: <Widget>[
                  ProfileFieldsECard(
                    width: MediaQuery.of(context).size.width,
                    labelText: 'Student/Teacher Name',
                    initialText: '',
                  ),
                  ProfileFieldsECard(
                    width: MediaQuery.of(context).size.width,
                    labelText: 'Student/Teacher Id',
                    initialText: '',
                  ),
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ProfileFieldsECard(
                        labelText: 'Standard',
                        initialText: '',
                      ),
                      ProfileFieldsECard(
                        labelText: 'Division',
                        initialText: '',
                      ),
                    ],
                  ),
                  ProfileFieldsECard(
                    width: MediaQuery.of(context).size.width,
                    labelText: 'Guardian Name',
                    initialText: '',
                  ),
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ProfileFieldsECard(
                        labelText: 'DOB',
                        initialText: '',
                      ),
                      ProfileFieldsECard(
                        labelText: 'Blood Group',
                        initialText: '',
                      ),
                    ],
                  ),
                  ProfileFieldsECard(
                    width: MediaQuery.of(context).size.width,
                    labelText: 'Mobile No',
                    initialText: '',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileFieldsECard extends StatelessWidget {
  final String initialText;
  final String labelText;
  final double width;

  const ProfileFieldsECard(
      {this.initialText, @required this.labelText, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: width == null ? MediaQuery.of(context).size.width / 2.5 : width,
      child: TextField(
        enabled: false,
        controller: TextEditingController(text: initialText),
        keyboardType: TextInputType.text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: kTextFieldDecoration.copyWith(
          // hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
