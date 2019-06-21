import 'package:acadamicConnect/Components/CustomLoginTypeBtn.dart';
import 'package:acadamicConnect/Components/LoginRoundedButton.dart';
import 'package:acadamicConnect/Components/ReusableRoundedButton.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/Resources.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:acadamicConnect/pages/Login/ForgotPassword.dart';
import 'package:acadamicConnect/pages/Profiles/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MobileLoginPage.dart';
import 'package:flip_card/flip_card.dart';

class LoginPage extends StatefulWidget {
  static String loginTypeSelected = 'S';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  String idHint = string.student_id;
  bool isRegistering = false;
  String notYetRegisteringText = string.not_registered;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: TopBar(
        title: string.login,
        child: kBackBtn,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextField(
                  onChanged: (id) {},
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: string.school_name_code_hint,
                    labelText: string.school_name_code,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  onChanged: (id) {},
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                    if (LoginPage.loginTypeSelected == 'S') {
                      setState(() {
                        idHint = string.student_id;
                      });
                    }
                    if (LoginPage.loginTypeSelected == 'PT') {
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
                  onChanged: (email) {},
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: string.email_hint,
                    labelText: string.email,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  obscureText: true,
                  onChanged: (password) {},
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: string.password_hint,
                    labelText: string.password,
                  ),
                ),
                isRegistering
                    ? SizedBox(
                        height: 15,
                      )
                    : Container(),
                isRegistering
                    ? TextField(
                        obscureText: true,
                        onChanged: (password) {},
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: string.password_hint,
                          labelText: string.confirm_password,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 15,
                ),
                Hero(
                  tag: 'otpForget',
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ReusableRoundedButton(
                          child: Text(
                            notYetRegisteringText,
                            style: TextStyle(
                              // color: kmainColorTeacher,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () {
                            cardKey.currentState.toggleCard();
                            setState(() {
                              isRegistering = !isRegistering;
                              notYetRegisteringText = isRegistering
                                  ? string.regidtered
                                  : string.not_registered;
                            });
                          },
                          height: 40,
                        ),
                        ReusableRoundedButton(
                          child: Text(
                            string.need_help,
                            style: TextStyle(
                              // color: kmainColorTeacher,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () {
                            //Forget Password Logic
                            kopenPage(context, ForgotPasswordPage());
                          },
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          FlipCard(
            speed: 100,
            key: cardKey,
            flipOnTouch: false,
            direction: FlipDirection.HORIZONTAL,
            front: Stack(
              children: <Widget>[
                LoginRoundedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ProfilePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            back: Stack(
              children: <Widget>[
                LoginRoundedButton(
                  heroTag: 'loginn',
                  label: string.register,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ProfilePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 30,
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Hero(
                tag: 'mobile',
                transitionOnUserGestures: true,
                child: ReusableRoundedButton(
                  child: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  // text: 'Mobile',
                  onPressed: () {
                    kopenPageBottom(
                      context,
                      MobileLoginPage(),
                    );
                  },
                  height: 50,
                  backgroundColor: Colors.redAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
