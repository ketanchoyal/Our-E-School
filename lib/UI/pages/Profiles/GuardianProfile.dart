import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/ReusableRoundedButton.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:provider/provider.dart';

import 'ProfilePage.dart';

class GuardianProfilePage extends StatefulWidget {
  static const id = 'GuardianPage';
  final String title;
  GuardianProfilePage({
    this.title = 'Profile',
    Key key,
  }) : super(key: key);

  final Color selectedButtonColor = Colors.red;
  final Color buttonBackGroundColor = Colors.white;

  _GuardianProfilePageState createState() => _GuardianProfilePageState();
}

class _GuardianProfilePageState extends State<GuardianProfilePage> {
  DateTime dateOfBirth;
  DateTime anniversaryDate;
  String path = '';
  UserType userType = UserType.UNKNOWN;
  bool isEditable = false;

  Future<Null> _selectDate(BuildContext context, DateTime date) async {
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
  }

  Color motherButtonColor;
  Color fatherButtonColor;
  Color otherButtonColor;

  // setColors(BuildContext context) {
  //   selectedButtonColor = Theme.of(context).primaryColor;
  //   buttonBackGroundColor = Theme.of(context).canvasColor;
  // }

  @override
  void initState() {
    // TODO: implement initState
    motherButtonColor = widget.selectedButtonColor;
    fatherButtonColor = widget.buttonBackGroundColor;
    otherButtonColor = widget.buttonBackGroundColor;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    // setColors(context);
    userType = Provider.of<UserType>(context);
    print("In Guardian ProfilePage " + UserTypeHelper.getValue(userType));
    if (userType == UserType.PARENT || userType == UserType.TEACHER) {
      isEditable = true;
    }
    return Scaffold(
      appBar: TopBar(
        title: widget.title,
        child: kBackBtn,
        onPressed: () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        },
      ),
      floatingActionButton: Visibility(
        visible: isEditable,
        child: FloatingActionButton(
          elevation: 20,
          backgroundColor: Colors.red,
          onPressed: () {},
          child: Icon(Icons.check),
        ),
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
                        Visibility(
                          visible: isEditable,
                          child: Positioned(
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
                      isEditable: isEditable,
                      // width: MediaQuery.of(context).size.width,
                      hintText: string.name_hint,
                      labelText: string.name,
                      onChanged: (name) {},
                      initialText: '',
                    ),
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
                          onChanged: (dob) {},
                          hintText: '',
                          initialText: anniversaryDate == null
                              ? ''
                              : anniversaryDate
                                  .toLocal()
                                  .toString()
                                  .substring(0, 10),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              await _selectDate(context, dateOfBirth);
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: IgnorePointer(
                              child: ProfileFields(
                                isEditable: isEditable,
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
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ProfileFields(
                            isEditable: isEditable,
                            hintText: string.blood_group_hint,
                            labelText: string.blood_group,
                            onChanged: (bg) {},
                            initialText: '',
                          ),
                        ),
                      ],
                    ),
                    ProfileFields(
                      isEditable: isEditable,
                      // width: MediaQuery.of(context).size.width,
                      textInputType: TextInputType.number,
                      hintText: '',
                      labelText: string.mobile_no,
                      onChanged: (id) {},
                      initialText: '',
                    ),
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
                          height: 50,
                          onPressed: () {},
                          backgroundColor: motherButtonColor,
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
                          backgroundColor: fatherButtonColor,
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
                          onPressed: () {},
                          backgroundColor: otherButtonColor,
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
  }
}
