import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/CustomCheckBoxGroup.dart';
import 'package:ourESchool/UI/Widgets/CustomRadioButton.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/core/enums/UserType.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: string.about,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              'Group Check Box',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Shape Disabled',
                        style: TextStyle(fontSize: 15),
                      ),
                      CustomCheckBoxGroup(
                        buttonColor: Theme.of(context).canvasColor,
                        buttonLables: [
                          "Monday",
                          "Tuesday",
                          "Wednesday",
                          "Thursday",
                        ],
                        buttonValuesList: [
                          "Monday",
                          "Tuesday",
                          "Wednesday",
                          "Thursday",
                        ],
                        checkBoxButtonValues: (values) {
                          print(values);
                        },
                        defaultSelected: "Monday",
                        horizontal: true,
                        width: 120,
                        // hight: 50,
                        selectedColor: Theme.of(context).accentColor,
                        padding: 5,
                        // enableShape: true,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Shape Enabled',
                        style: TextStyle(fontSize: 15),
                      ),
                      CustomCheckBoxGroup(
                        buttonColor: Theme.of(context).canvasColor,
                        buttonLables: [
                          "Thursday",
                          "Friday",
                          "Saturday",
                          "Sunday",
                        ],
                        buttonValuesList: [
                          "Thursday",
                          "Friday",
                          "Saturday",
                          "Sunday",
                        ],
                        checkBoxButtonValues: (values) {
                          print(values);
                        },
                        defaultSelected: "Sunday",
                        horizontal: true,
                        width: 120,
                        // hight: 50,
                        selectedColor: Theme.of(context).accentColor,
                        padding: 5,
                        enableShape: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Text(
              'Custom Radio Button',
              style: TextStyle(fontSize: 20),
            ),
            Column(
              children: <Widget>[
                CustomRadioButton(
                  // horizontal: true,
                  buttonColor: Theme.of(context).canvasColor,
                  buttonLables: ['Student', 'Parent/Teacher'],
                  buttonValues: [UserType.STUDENT, UserType.TEACHER],
                  radioButtonValue: (value) {
                    print(value);
                  },
                  selectedColor: Theme.of(context).accentColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
