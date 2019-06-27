import 'package:acadamicConnect/UI/Utility/Resources.dart';
import 'package:acadamicConnect/UI/Utility/constants.dart';
import 'package:acadamicConnect/UI/Widgets/CustomLoginTypeBtn.dart';
import 'package:acadamicConnect/UI/Widgets/LoginRoundedButton.dart';
import 'package:acadamicConnect/UI/Widgets/ReusableRoundedButton.dart';
import 'package:acadamicConnect/UI/Widgets/TopBar.dart';
import 'package:flutter/material.dart';

import '../Home.dart';

class MobileLoginPage extends StatefulWidget {
  static String loginTypeSelected = 'S';
  @override
  _MobileLoginPageState createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  bool isEnabled = true;
  String idHint = string.student_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: TopBar(
        title: string.mobile,
        child: kBackBtn,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 31),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Hero(
                  tag: 'mobile',
                  transitionOnUserGestures: true,
                  child: ReusableRoundedButton(
                    child: Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    ),
                    // text: 'Mobile',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    height: 50,
                    backgroundColor: Colors.redAccent,
                  ),
                ),
              ),
            ),
            LoginRoundedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Home(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // fit: StackFit.expand,
              children: [
                Column(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextField(
                      enabled: isEnabled,
                      onChanged: (id) {},
                      keyboardType: TextInputType.emailAddress,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: string.school_name_code_hint,
                        labelText: string.school_name_code,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      enabled: isEnabled,
                      onChanged: (id) {},
                      keyboardType: TextInputType.emailAddress,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: string.student_teacher_id_hint,
                        labelText: idHint,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomLoginTypeBtn(
                      onPressed: () {
                        if (MobileLoginPage.loginTypeSelected == 'S') {
                          setState(() {
                            idHint = string.student_id;
                          });
                        }
                        if (MobileLoginPage.loginTypeSelected == 'PT') {
                          setState(() {
                            idHint = string.student_or_teacher_id;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      enabled: isEnabled,
                      onChanged: (email) {},
                      keyboardType: TextInputType.number,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: string.mobile_hint,
                        labelText: string.mobile_no,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      enabled: !isEnabled,
                      onChanged: (password) {},
                      keyboardType: TextInputType.number,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: string.otp_hint,
                        labelText: string.otp,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Hero(
                      tag: 'otpForget',
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ReusableRoundedButton(
                            child: Text(
                              string.send_otp,
                              style: TextStyle(
                                // color: kmainColorTeacher,
                                fontSize: 15,
                              ),
                            ),
                            // text: "Forgot Pass?",
                            onPressed: () {
                              setState(() {
                                isEnabled = !isEnabled;
                              });
                            },
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
