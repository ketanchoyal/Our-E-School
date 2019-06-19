import 'package:acadamicConnect/Components/ReusableRoundedButton.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime dateOfBirth;

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
        title: 'Profile',
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
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Image(
                      height: MediaQuery.of(context).size.width / 2.5,
                      width: MediaQuery.of(context).size.width / 2.5,
                      image: NetworkImage(
                          "https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png"),
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
                      hintText: 'One which your parents gave',
                      labelText: 'Student/Teacher Name',
                      onChanged: (name) {},
                      initialText: '',
                    ),
                    ProfileFields(
                      width: MediaQuery.of(context).size.width,
                      hintText: 'One which school gave',
                      labelText: 'Student/Teacher Id',
                      onChanged: (id) {},
                      initialText: '',
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ProfileFields(
                          labelText: 'Standard',
                          onChanged: (std) {},
                          hintText: '',
                          initialText: '',
                        ),
                        ProfileFields(
                          labelText: 'Division',
                          onChanged: (div) {},
                          hintText: '',
                          initialText: '',
                        ),
                      ],
                    ),
                    ProfileFields(
                      width: MediaQuery.of(context).size.width,
                      hintText: 'Father/Mother Name',
                      labelText: 'Guardian Name',
                      onChanged: (guardianName) {},
                      initialText: '',
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ProfileFields(
                          onTap: () async {
                            await _selectDate(context);
                          },
                          labelText: 'DOB',
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
                          hintText: 'A +ve/O -ve',
                          labelText: 'Blood Group',
                          onChanged: (bg) {},
                          initialText: '',
                        ),
                      ],
                    ),
                    ProfileFields(
                      width: MediaQuery.of(context).size.width,
                      textInputType: TextInputType.number,
                      hintText: 'Your parents..',
                      labelText: 'Mobile No',
                      onChanged: (id) {},
                      initialText: '',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Guardian\'s Profile:',
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
                            'Mother',
                            style: ktitleStyle.copyWith(
                                color: Colors.white.withOpacity(0.8)),
                          ),
                          onPressed: () {},
                          backgroundColor: kmainColorParents,
                          height: 40,
                        ),
                        ReusableRoundedButton(
                          elevation: 5,
                          child: Text(
                            'Father',
                            style: ktitleStyle.copyWith(
                                color: Colors.white.withOpacity(0.8)),
                          ),
                          onPressed: () {},
                          backgroundColor: kmainColorParents,
                          // height: 50,
                        ),
                        ReusableRoundedButton(
                          elevation: 5,
                          child: Text(
                            'Guardian',
                            style: ktitleStyle.copyWith(
                                color: Colors.white.withOpacity(0.8)),
                          ),
                          onPressed: () {},
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
