import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';

import 'ReusableRoundedButton.dart';

class LoginRoundedButton extends StatelessWidget {
  final Function onPressed;
  const LoginRoundedButton({
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      right: 30,
      width: MediaQuery.of(context).size.width,
      child: Align(
          alignment: Alignment.bottomRight,
          child: Hero(
            tag: 'login',
            transitionOnUserGestures: true,
            child: ReusableRoundedButton(
              child: Text(
                'Login',
                style: TextStyle(
                  // color: kmainColorTeacher,
                  fontSize: 15,
                ),
              ),
              // text: 'Login',
              onPressed: onPressed,
              height: 50,
              backgroundColor: Colors.redAccent,
            ),
          )),
    );
  }
}
