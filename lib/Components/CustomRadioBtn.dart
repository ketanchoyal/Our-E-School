import 'package:acadamicConnect/pages/Login/LoginPage.dart';
import 'package:acadamicConnect/pages/Login/MobileLoginPage.dart';
import 'package:flutter/material.dart';

import 'ReusableRoundedButton.dart';

class CustomRadioBtn extends StatefulWidget {

  static Color selectedBtnColor = Colors.redAccent;
  static Color selectedBtnFontColor = Colors.white;

  @override
  _CustomRadioBtnState createState() => _CustomRadioBtnState();
}

class _CustomRadioBtnState extends State<CustomRadioBtn> {
  Color studentBtnColor = CustomRadioBtn.selectedBtnColor;
  Color parentTeacherBtnColor;
  Color studentBtnTextColor = CustomRadioBtn.selectedBtnFontColor;
  Color parentTeacherBtnTextColor;

  loginTypeBtnTapped(String btn) {
    if (btn == 'S') {
      if (studentBtnColor != CustomRadioBtn.selectedBtnColor) {
        setState(() {
          parentTeacherBtnColor = null;
          parentTeacherBtnTextColor = null;
          studentBtnColor = CustomRadioBtn.selectedBtnColor;
          studentBtnTextColor = CustomRadioBtn.selectedBtnFontColor;
          LoginPage.loginTypeSelected = 'S';
          MobileLoginPage.loginTypeSelected = 'S';
        });
      }
    } else if (btn == 'PT'){
      if (parentTeacherBtnColor != CustomRadioBtn.selectedBtnColor) {
        setState(() {
          parentTeacherBtnColor = CustomRadioBtn.selectedBtnColor;
          parentTeacherBtnTextColor = CustomRadioBtn.selectedBtnFontColor;
          studentBtnTextColor = null;
          studentBtnColor = null;
          LoginPage.loginTypeSelected = 'PT';
          MobileLoginPage.loginTypeSelected = 'PT';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Hero(
        tag: 'radioo',
              child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: ReusableRoundedButton(
                backgroundColor: studentBtnColor,
                onPressed: () {
                  loginTypeBtnTapped('S');
                },
                child: Text(
                  'Student',
                  style: TextStyle(
                    color: studentBtnTextColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ReusableRoundedButton(
                onPressed: () {
                  loginTypeBtnTapped('PT');
                },
                backgroundColor: parentTeacherBtnColor,
                child: Text(
                  'Parent/Teacher',
                  style: TextStyle(
                    color: parentTeacherBtnTextColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
