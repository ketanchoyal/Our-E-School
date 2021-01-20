import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/ReusableRoundedButton.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ourESchool/UI/pages/BaseView.dart';
import 'package:ourESchool/UI/pages/Home.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/core/viewmodel/ProfilePageModel.dart';
import 'package:ourESchool/locator.dart';
import 'package:provider/provider.dart';

import 'GuardianProfile.dart';

class ProfilePage extends StatefulWidget {
  static const id = 'ProfilePage';
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime dateOfBirth;
  UserType userType = UserType.UNKNOWN;
  bool guardiansPanel = false;
  String path = 'default';
  // String tempPath = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
        _dob = picked.toLocal().toString().substring(0, 10);
      });
    }
  }

  SharedPreferencesHelper _sharedPreferencesHelper =
      locator<SharedPreferencesHelper>();

  String _name = '';
  String _enrollNo = '';
  String _standard = '';
  String _division = '';
  String _guardianName = '';
  String _bloodGroup = '';
  String _dob = '';
  String _mobileNo = '';
  int a = 0;

  floatingButoonPressed(var model, UserType userType, User firebaseUser) async {
    bool res = false;

    // var firebaseUser = Provider.of<FirebaseUser>(context, listen: false);

    if (_bloodGroup.isEmpty ||
        _division.isEmpty ||
        _name.isEmpty ||
        _dob.isEmpty ||
        _guardianName.isEmpty ||
        _mobileNo.isEmpty ||
        _standard.isEmpty ||
        _enrollNo.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(ksnackBar(
          context, 'You Need to fill all the details and a profile Photo'));
    } else {
      if (model.state == ViewState.Idle) {
        res = await model.setUserProfileData(
          user: AppUser(
            bloodGroup: _bloodGroup.trim(),
            displayName: _name.trim(),
            division: _division.trim(),
            dob: _dob.trim(),
            guardianName: _guardianName.trim(),
            mobileNo: _mobileNo.trim(),
            standard: _standard.trim(),
            enrollNo: _enrollNo.trim(),
            email: firebaseUser.email,
            firebaseUuid: firebaseUser.uid,
            id: await _sharedPreferencesHelper.getLoggedInUserId(),
            isTeacher: userType == UserType.TEACHER ? true : false,
            isVerified: firebaseUser.emailVerified,
            photoUrl: path,
            connection: await getConnection(userType),
          ),
          userType: userType,
        );
      }
    }

    if (res == true) {
      Navigator.pushNamedAndRemoveUntil(context, Home.id, (r) => false);
    }
  }

  Future<Map<String, dynamic>> getConnection(UserType userType) async {
    String connection = userType == UserType.STUDENT
        ? await _sharedPreferencesHelper.getParentsIds()
        : await _sharedPreferencesHelper.getChildIds();

    if (connection == 'N.A') {
      return null;
    }

    return jsonDecode(connection);
  }

  @override
  Widget build(BuildContext context) {
    userType = Provider.of<UserType>(context, listen: false);
    var firebaseUser = Provider.of<User>(context, listen: true);

    if (userType == UserType.STUDENT) {
      guardiansPanel = false;
    } else {
      guardiansPanel = true;
    }
    return BaseView<ProfilePageModel>(
        onModelReady: (model) => model.getUserProfileData(),
        builder: (context, model, child) {
          if (model.state == ViewState.Idle) {
            if (a == 0) {
              if (model.userProfile != null) {
                AppUser user = model.userProfile;
                _name = user.displayName;
                _enrollNo = user.enrollNo;
                _standard = user.standard;
                _division = user.division.toUpperCase();
                _guardianName = user.guardianName;
                _bloodGroup = user.bloodGroup;
                _dob = user.dob;
                _mobileNo = user.mobileNo;
                path = user.photoUrl;
                a++;
              }
            }
          }

          return Scaffold(
            key: _scaffoldKey,
            appBar: TopBar(
              title: string.profile,
              child: kBackBtn,
              onPressed: () {
                if (model.state ==
                    ViewState.Idle) if (Navigator.canPop(context))
                  Navigator.pop(context);
              },
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Save',
              elevation: 20,
              backgroundColor: Colors.red,
              onPressed: () async {
                await floatingButoonPressed(model, userType, firebaseUser);
              },
              child: model.state == ViewState.Busy
                  ? SpinKitDoubleBounce(
                      color: Colors.white,
                      size: 20,
                    )
                  : Icon(Icons.check),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    // fit: StackFit.loose,
                    children: <Widget>[
                      model.state2 == ViewState.Busy
                          ? kBuzyPage(color: Theme.of(context).primaryColor)
                          : buildProfilePhotoWidget(context, model),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ProfileFields(
                              width: MediaQuery.of(context).size.width,
                              hintText: string.student_teacher_name_hint,
                              labelText: string.student_teacher_name,
                              onChanged: (name) {
                                print(name);
                                _name = name;
                              },
                              controller: TextEditingController(text: _name),
                            ),
                            ProfileFields(
                              width: MediaQuery.of(context).size.width,
                              hintText: string.student_teacher_id_hint,
                              labelText: string.student_or_teacher_id,
                              onChanged: (id) {
                                _enrollNo = id;
                              },
                              controller:
                                  TextEditingController(text: _enrollNo),
                            ),
                            Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: ProfileFields(
                                    labelText: string.standard,
                                    onChanged: (std) {
                                      _standard = std;
                                    },
                                    hintText: '',
                                    controller:
                                        TextEditingController(text: _standard),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ProfileFields(
                                    labelText: string.division,
                                    onChanged: (div) {
                                      _division = div;
                                    },
                                    hintText: '',
                                    controller:
                                        TextEditingController(text: _division),
                                  ),
                                ),
                              ],
                            ),
                            ProfileFields(
                              width: MediaQuery.of(context).size.width,
                              hintText: string.father_mother_name,
                              labelText: string.guardian_name,
                              onChanged: (guardianName) {
                                _guardianName = guardianName;
                              },
                              controller:
                                  TextEditingController(text: _guardianName),
                            ),
                            Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      await _selectDate(context);
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: IgnorePointer(
                                      child: ProfileFields(
                                          labelText: string.dob,
                                          textInputType: TextInputType.number,
                                          onChanged: (dob) {
                                            _dob = dob;
                                          },
                                          hintText: '',
                                          controller: TextEditingController(
                                            text: _dob,
                                          )
                                          // initialText: dateOfBirth == null
                                          //     ? ''
                                          //     : dateOfBirth
                                          //         .toLocal()
                                          //         .toString()
                                          //         .substring(0, 10),
                                          ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ProfileFields(
                                    // width: MediaQuery.of(context).size.width,
                                    hintText: string.blood_group_hint,
                                    labelText: string.blood_group,
                                    onChanged: (bg) {
                                      _bloodGroup = bg;
                                    },
                                    controller: TextEditingController(
                                        text: _bloodGroup),
                                  ),
                                ),
                              ],
                            ),
                            ProfileFields(
                              width: MediaQuery.of(context).size.width,
                              textInputType: TextInputType.number,
                              hintText: string.your_parents,
                              labelText: string.mobile_no,
                              onChanged: (mobile_no) {
                                _mobileNo = mobile_no;
                              },
                              controller:
                                  TextEditingController(text: _mobileNo),
                            ),
                            Visibility(
                              visible: false,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: ReusableRoundedButton(
                                          elevation: 5,
                                          child: Text(
                                            string.mother,
                                            textAlign: TextAlign.center,
                                            style: ktitleStyle.copyWith(
                                                color: Colors.white
                                                    .withOpacity(0.8)),
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
                                      ),
                                      Expanded(
                                        child: ReusableRoundedButton(
                                          elevation: 5,
                                          child: Text(
                                            string.father,
                                            textAlign: TextAlign.center,
                                            style: ktitleStyle.copyWith(
                                                color: Colors.white
                                                    .withOpacity(0.8)),
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
                                      ),
                                      Expanded(
                                        child: ReusableRoundedButton(
                                          elevation: 5,
                                          child: Text(
                                            string.other,
                                            textAlign: TextAlign.center,
                                            style: ktitleStyle.copyWith(
                                                color: Colors.white
                                                    .withOpacity(0.8)),
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
            ),
          );
        });
  }

  Widget buildProfilePhotoWidget(BuildContext context, ProfilePageModel model) {
    return Row(
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
                child: Hero(
                  tag: 'profileeee',
                  transitionOnUserGestures: true,
                  child: Image(
                      height: MediaQuery.of(context).size.width / 2.5,
                      width: MediaQuery.of(context).size.width / 2.5,
                      image: setImage()),
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
                            FileType.image, mounted, context);
                        setState(() {
                          path = _path;
                          // tempPath = _path;
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
    );
  }

  ImageProvider<dynamic> setImage() {
    if (path.contains('https')) {
      return NetworkImage(path);
    } else if (path == 'default' || path == null) {
      return AssetImage(assetsString.student_welcome);
    } else {
      return AssetImage(path);
    }
  }
}

class ProfileFields extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function onChanged;
  final double width;
  final Function onTap;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool isEditable;

  const ProfileFields(
      {@required this.labelText,
      this.hintText,
      this.onChanged,
      this.controller,
      this.onTap,
      this.textInputType,
      this.isEditable = true,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      // width: width == null ? MediaQuery.of(context).size.width / 2.5 : width,
      child: TextField(
        enabled: isEditable,
        onTap: onTap,
        controller: controller,
        // controller: TextEditingController(text: initialText),
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
