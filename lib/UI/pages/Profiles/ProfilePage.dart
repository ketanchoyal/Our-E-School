import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/ReusableRoundedButton.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ourESchool/UI/pages/Home.dart';

import 'GuardianProfile.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime dateOfBirth;
  bool isTeacher = false;
  String path = '';

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        dateOfBirth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: string.profile,
        child: kBackBtn,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        backgroundColor: Colors.red,
        onPressed: () {
          kopenPage(context, Home());
        },
        child: Icon(Icons.check),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            // fit: StackFit.loose,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
                    child: Stack(
                      children: <Widget>[
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Image(
                            height: MediaQuery.of(context).size.width / 2.5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            image: path == ''
                                ? NetworkImage(
                                    "https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png",
                                  )
                                : AssetImage(path),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 45,
                            width: 45,
                            child: Card(
                              elevation: 5,
                              color: Colors.white70,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black38,
                                  size: 25,
                                ),
                                onPressed: () async {
                                  String _path = await openFileExplorer(
                                      FileType.IMAGE, mounted);
                                  setState(() {
                                    path = _path;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ProfileFields(
                      width: MediaQuery.of(context).size.width,
                      hintText: string.student_teacher_name_hint,
                      labelText: string.student_teacher_name,
                      onChanged: (name) {},
                      initialText: '',
                    ),
                    ProfileFields(
                      width: MediaQuery.of(context).size.width,
                      hintText: string.student_teacher_id_hint,
                      labelText: string.student_or_teacher_id,
                      onChanged: (id) {},
                      initialText: '',
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ProfileFields(
                          labelText: string.standard,
                          onChanged: (std) {},
                          hintText: '',
                          initialText: '',
                        ),
                        ProfileFields(
                          labelText: string.division,
                          onChanged: (div) {},
                          hintText: '',
                          initialText: '',
                        ),
                      ],
                    ),
                    ProfileFields(
                      width: MediaQuery.of(context).size.width,
                      hintText: string.father_mother_name,
                      labelText: string.guardian_name,
                      onChanged: (guardianName) {},
                      initialText: '',
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () async {
                            await _selectDate(context);
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: IgnorePointer(
                            child: ProfileFields(
                              labelText: string.dob,
                              textInputType: TextInputType.number,
                              onChanged: (dob) {},
                              hintText: '',
                              initialText: dateOfBirth == null
                                  ? ''
                                  : dateOfBirth
                                      .toLocal()
                                      .toString()
                                      .substring(0, 10),
                            ),
                          ),
                        ),
                        ProfileFields(
                          // width: MediaQuery.of(context).size.width,
                          hintText: string.blood_group_hint,
                          labelText: string.blood_group,
                          onChanged: (bg) {},
                          initialText: '',
                        ),
                      ],
                    ),
                    ProfileFields(
                      width: MediaQuery.of(context).size.width,
                      textInputType: TextInputType.number,
                      hintText: string.your_parents,
                      labelText: string.mobile_no,
                      onChanged: (id) {},
                      initialText: '',
                    ),
                    Visibility(
                      visible: !isTeacher,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              string.guardians_profile,
                              style: ktitleStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                // color: kmainColorParents.withOpacity(0.4),
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ReusableRoundedButton(
                                elevation: 5,
                                child: Text(
                                  string.mother,
                                  style: ktitleStyle.copyWith(
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                                onPressed: () {
                                  kopenPage(
                                    context,
                                    GuardianProfilePage(
                                      title: string.mother,
                                    ),
                                  );
                                },
                                backgroundColor: kmainColorParents,
                                height: 40,
                              ),
                              ReusableRoundedButton(
                                elevation: 5,
                                child: Text(
                                  string.father,
                                  style: ktitleStyle.copyWith(
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                                onPressed: () {
                                  kopenPage(
                                    context,
                                    GuardianProfilePage(
                                      title: string.father,
                                    ),
                                  );
                                },
                                backgroundColor: kmainColorParents,
                                // height: 50,
                              ),
                              ReusableRoundedButton(
                                elevation: 5,
                                child: Text(
                                  string.other,
                                  style: ktitleStyle.copyWith(
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                                onPressed: () {
                                  kopenPage(
                                    context,
                                    GuardianProfilePage(
                                      title: string.other,
                                    ),
                                  );
                                },
                                backgroundColor: kmainColorParents,
                                // height: 50,
                              ),
                            ],
                          )
                        ],
                      ),
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

class ProfileFields extends StatelessWidget {
  final String initialText;
  final String labelText;
  final String hintText;
  final Function onChanged;
  final double width;
  final Function onTap;
  final TextInputType textInputType;

  const ProfileFields(
      {this.initialText,
      @required this.labelText,
      this.hintText,
      @required this.onChanged,
      this.onTap,
      this.textInputType,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: width == null ? MediaQuery.of(context).size.width / 2.5 : width,
      child: TextField(
        onTap: onTap,
        controller: TextEditingController(text: initialText),
        onChanged: onChanged,
        keyboardType: textInputType ?? TextInputType.text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: kTextFieldDecoration.copyWith(
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
