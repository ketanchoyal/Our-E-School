import 'package:acadamicConnect/pages/Login/LoginPage.dart';
import 'package:acadamicConnect/pages/Login/MobileLoginPage.dart';
import 'package:flutter/material.dart';
import 'ReusableRoundedButton.dart';

class CustomLoginTypeBtn extends StatefulWidget {
  static Color selectedBtnColor = Colors.redAccent;
  static Color selectedBtnFontColor = Colors.white;

  final Function onPressed;

  CustomLoginTypeBtn({this.onPressed});

  @override
  _CustomLoginTypeBtnState createState() => _CustomLoginTypeBtnState();
}

class _CustomLoginTypeBtnState extends State<CustomLoginTypeBtn> {
  Color studentBtnColor = CustomLoginTypeBtn.selectedBtnColor;
  Color parentTeacherBtnColor;
  Color studentBtnTextColor = CustomLoginTypeBtn.selectedBtnFontColor;
  Color parentTeacherBtnTextColor;

  loginTypeBtnTapped(String btn) {
    if (btn == 'S') {
      if (studentBtnColor != CustomLoginTypeBtn.selectedBtnColor) {
        setState(() {
          parentTeacherBtnColor = null;
          parentTeacherBtnTextColor = null;
          studentBtnColor = CustomLoginTypeBtn.selectedBtnColor;
          studentBtnTextColor = CustomLoginTypeBtn.selectedBtnFontColor;
          LoginPage.loginTypeSelected = 'S';
          MobileLoginPage.loginTypeSelected = 'S';
        });
      }
    }
    if (btn == 'PT') {
      if (parentTeacherBtnColor != CustomLoginTypeBtn.selectedBtnColor) {
        setState(() {
          parentTeacherBtnColor = CustomLoginTypeBtn.selectedBtnColor;
          parentTeacherBtnTextColor = CustomLoginTypeBtn.selectedBtnFontColor;
          studentBtnTextColor = null;
          studentBtnColor = null;
          LoginPage.loginTypeSelected = 'PT';
          MobileLoginPage.loginTypeSelected = 'PT';
        });
      }
    }
    if (widget.onPressed != null) {
      widget.onPressed();
    }
    print(LoginPage.loginTypeSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(maxHeight: 40, maxWidth: 50),
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
