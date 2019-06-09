import 'package:acadamicConnect/Components/ReusableRoundedButton.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime dateOfBirth;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
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
        child: Icon(
          Icons.check
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          // fit: StackFit.loose,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Image(
                    height: 160,
                    width: 160,
                    image: NetworkImage(
                        "https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png"),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Container(
                    height: 40,
                    width: 50,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Icon(Icons.edit, size: 25),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
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
                        onChanged: (dob) {},
                        hintText: '',
                        initialText: dateOfBirth == null
                            ? ''
                            : dateOfBirth.toLocal().toString(),
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
                ],
              ),
            )
          ],
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

  const ProfileFields(
      {this.initialText,
      @required this.labelText,
      this.hintText,
      @required this.onChanged,
      this.onTap,
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
        keyboardType: TextInputType.text,
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
