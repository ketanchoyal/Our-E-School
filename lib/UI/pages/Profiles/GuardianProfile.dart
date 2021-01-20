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
import 'ProfilePage.dart';

class GuardianProfilePage extends StatefulWidget {
  static const id = 'GuardianPage';
  final String title;
  GuardianProfilePage({
    this.title = 'Profile',
    Key key,
  }) : super(key: key);

  _GuardianProfilePageState createState() => _GuardianProfilePageState();
}

class _GuardianProfilePageState extends State<GuardianProfilePage> {
  DateTime dateOfBirth;
  DateTime anniversaryDate;
  String path = 'default';
  UserType userType = UserType.UNKNOWN;
  bool isEditable = false;
  bool floatingButtonVisibility = false;

  Future<DateTime> _selectDate(BuildContext context, DateTime date) async {
    final DateTime picked = await showDatePicker(
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        date = picked;
      });
    }
    return picked;
  }

  @override
  void initState() {
    super.initState();
  }

  SharedPreferencesHelper _sharedPreferencesHelper =
      locator<SharedPreferencesHelper>();

  String _name = '';
  String _childrenNameName = '';
  String _bloodGroup = '';
  String _dob = '';
  String _mobileNo = '';
  int a = 0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  floatingButtonPressed(var model, UserType userType, User firebaseUser) async {
    bool res = false;

    if (_bloodGroup.isEmpty ||
        _name.isEmpty ||
        _dob.isEmpty ||
        _childrenNameName.isEmpty ||
        _mobileNo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(ksnackBar(
          context, 'You Need to fill all the details and a profile Photo'));
    } else {
      if (model.state == ViewState.Idle) {
        res = await model.setUserProfileData(
          user: AppUser(
              bloodGroup: _bloodGroup.trim(),
              displayName: _name.trim(),
              dob: _dob.trim(),
              guardianName: _childrenNameName.trim(),
              mobileNo: _mobileNo.trim(),
              email: firebaseUser.email,
              firebaseUuid: firebaseUser.uid,
              id: await _sharedPreferencesHelper.getLoggedInUserId(),
              isTeacher: false,
              isVerified: firebaseUser.emailVerified,
              connection: await getConnection(userType),
              photoUrl: path),
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

    print("In Guardian ProfilePage " + UserTypeHelper.getValue(userType));
    if (userType == UserType.PARENT || userType == UserType.TEACHER) {
      isEditable = true;
      floatingButtonVisibility = true;
    }
    return BaseView<ProfilePageModel>(
      onModelReady: (model) => model.getUserProfileData(),
      builder: (context, model, child) {
        if (model.state == ViewState.Idle) {
          isEditable = true;
          if (a == 0) {
            if (model.userProfile != null) {
              AppUser user = model.userProfile;
              _name = user.displayName;
              _childrenNameName = user.guardianName;
              _bloodGroup = user.bloodGroup;
              _dob = user.dob;
              _mobileNo = user.mobileNo;
              path = user.photoUrl;
              a++;
            }
          }
        } else {
          isEditable = false;
        }

        return Scaffold(
          key: _scaffoldKey,
          appBar: TopBar(
            title: widget.title,
            child: kBackBtn,
            onPressed: () {
              if (Navigator.canPop(context)) Navigator.pop(context);
            },
          ),
          floatingActionButton: Visibility(
            visible: floatingButtonVisibility,
            child: FloatingActionButton(
              tooltip: 'Save',
              elevation: 20,
              backgroundColor: Colors.red,
              onPressed: () async {
                await floatingButtonPressed(model, userType, firebaseUser);
              },
              child: model.state == ViewState.Busy
                  ? SpinKitDoubleBounce(
                      color: Colors.white,
                      size: 20,
                    )
                  : Icon(Icons.check),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                // fit: StackFit.loose,
                children: <Widget>[
                  model.state2 == ViewState.Busy
                      ? kBuzyPage(color: Theme.of(context).primaryColor)
                      : buildProfilePhotoWidget(context, model),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ProfileFields(
                            isEditable: isEditable,
                            // width: MediaQuery.of(context).size.width,
                            hintText: string.name_hint,
                            labelText: string.name,
                            onChanged: (name) {
                              _name = name;
                            },
                            controller: TextEditingController(
                              text: _name,
                            )),
                        InkWell(
                          onTap: () async {
                            await _selectDate(context, anniversaryDate);
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: IgnorePointer(
                            child: ProfileFields(
                              isEditable: isEditable,
                              width: MediaQuery.of(context).size.width,
                              labelText: string.anniversary_date,
                              textInputType: TextInputType.number,
                              onChanged: (anniversary) {},
                              hintText: '',
                              controller: TextEditingController(
                                text: anniversaryDate == null
                                    ? ''
                                    : anniversaryDate
                                        .toLocal()
                                        .toString()
                                        .substring(0, 10),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  dateOfBirth =
                                      await _selectDate(context, dateOfBirth);
                                  setState(() {
                                    _dob = dateOfBirth
                                        .toLocal()
                                        .toString()
                                        .substring(0, 10);
                                  });
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: IgnorePointer(
                                  child: ProfileFields(
                                      isEditable: isEditable,
                                      labelText: string.dob,
                                      textInputType: TextInputType.number,
                                      onChanged: (dob) {
                                        _dob = dob;
                                      },
                                      hintText: '',
                                      controller: TextEditingController(
                                        text: _dob,
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ProfileFields(
                                  isEditable: isEditable,
                                  hintText: string.blood_group_hint,
                                  labelText: string.blood_group,
                                  onChanged: (bg) {
                                    _bloodGroup = bg;
                                  },
                                  controller: TextEditingController(
                                    text: _bloodGroup,
                                  )),
                            ),
                          ],
                        ),
                        ProfileFields(
                            isEditable: isEditable,
                            // width: MediaQuery.of(context).size.width,
                            textInputType: TextInputType.number,
                            hintText: '',
                            labelText: string.mobile_no,
                            onChanged: (mobileNo) {
                              _mobileNo = mobileNo;
                            },
                            controller: TextEditingController(
                              text: _mobileNo,
                            )),
                        ProfileFields(
                            isEditable: isEditable,
                            // width: MediaQuery.of(context).size.width,
                            textInputType: TextInputType.text,
                            hintText: "use ',' to seprate name",
                            labelText: 'Childrens Name..',
                            onChanged: (names) {
                              _childrenNameName = names;
                            },
                            controller: TextEditingController(
                              text: _childrenNameName,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'You Are....',
                            style: ktitleStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ReusableRoundedButton(
                              elevation: 5,
                              height: 50,
                              onPressed: () {},
                              backgroundColor: Theme.of(context).primaryColor,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Mother',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                            ReusableRoundedButton(
                              height: 50,
                              onPressed: () {},
                              elevation: 5,
                              backgroundColor: Theme.of(context).canvasColor,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Father',
                                  style: TextStyle(
                                      // color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                            ReusableRoundedButton(
                              height: 50,
                              elevation: 5,
                              onPressed: () {},
                              backgroundColor: Theme.of(context).canvasColor,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Other',
                                  style: TextStyle(
                                      // color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
                child: Image(
                    height: MediaQuery.of(context).size.width / 2.5,
                    width: MediaQuery.of(context).size.width / 2.5,
                    image: setImage()),
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
    } else if (path == 'default') {
      return AssetImage(assetsString.student_welcome);
    } else {
      return AssetImage(path);
    }
  }
}
