import 'package:acadamicConnect/Components/ReusableRoundedButton.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key}) : super(key: key);

  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: 'Forgot Password',
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 25.0, left: 25.0, right: 25.0, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, ),
              child: Text(
                'Email Registered mail-id to recover your account',
                style: ktitleStyle,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              obscureText: true,
              onChanged: (email) {},
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'you@example.com',
                labelText: 'Email',
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ReusableRoundedButton(
              elevation: 5,
              child: Text(
                "Send recovery mail",
                style: TextStyle(
                  // color: kmainColorTeacher,
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                //Sent Password reset link logic
              },
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
