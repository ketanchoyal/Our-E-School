import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ProfilePage.dart';

class GuardianProfilePage extends StatefulWidget {
  final String title;
  GuardianProfilePage({@required this.title, Key key}) : super(key: key);

  _GuardianProfilePageState createState() => _GuardianProfilePageState();
}

class _GuardianProfilePageState extends State<GuardianProfilePage> {
  DateTime dateOfBirth;
  DateTime anniversaryDate;
  String path = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: widget.title,
        child: kBackBtn,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        backgroundColor: Colors.red,
        onPressed: () {},
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
                            image: path == '' ? NetworkImage(
                                "https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png",
                                ) : AssetImage(path),
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
                                  String _path =
                                      await openFileExplorer(FileType.IMAGE, mounted);
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
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ProfileFields(
                      width: MediaQuery.of(context).size.width,
                      hintText: string.name_hint,
                      labelText: string.name,
                      onChanged: (name) {},
                      initialText: '',
                    ),
                    ProfileFields(
                      width: MediaQuery.of(context).size.width,
                      onTap: () async {
                        await _selectDate(context, anniversaryDate);
                      },
                      labelText: string.anniversary_date,
                      textInputType: TextInputType.number,
                      onChanged: (dob) {},
                      hintText: '',
                      initialText: anniversaryDate == null
                          ? ''
                          : anniversaryDate.toLocal().toString().substring(0, 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ProfileFields(
                          onTap: () async {
                            await _selectDate(context, dateOfBirth);
                          },
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
                      hintText: '',
                      labelText: string.mobile_no,
                      onChanged: (id) {},
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
