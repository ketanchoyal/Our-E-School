import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/Resources.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          title: string.e_card,
          child: kBackBtn,
          onPressed: () {
            kbackBtn(context);
          },
        ),
        body: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        image: NetworkImage(
                          "https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png",
                        ),
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
                      labelText: string.student_teacher_name,
                      initialText: '',
                    ),
                    ProfileFieldsECard(
                      width: MediaQuery.of(context).size.width,
                      labelText: string.student_or_teacher_id,
                      initialText: '',
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ProfileFieldsECard(
                          labelText: string.standard,
                          initialText: '',
                        ),
                        ProfileFieldsECard(
                          labelText: string.division,
                          initialText: '',
                        ),
                      ],
                    ),
                    ProfileFieldsECard(
                      width: MediaQuery.of(context).size.width,
                      labelText: string.guardian_name,
                      initialText: '',
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ProfileFieldsECard(
                          labelText: string.dob,
                          initialText: '',
                        ),
                        ProfileFieldsECard(
                          labelText: string.blood_group,
                          initialText: '',
                        ),
                      ],
                    ),
                    ProfileFieldsECard(
                      width: MediaQuery.of(context).size.width,
                      labelText: string.mobile_no,
                      initialText: '',
                    ),
                  ],
                ),
              ),
            ],
          ),
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
