import 'package:flutter/material.dart';

import 'ReusableRoundedButton.dart';

class LoginRoundedButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final String heroTag;
  const LoginRoundedButton({this.onPressed, this.label, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      right: 30,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Hero(
          tag: heroTag ?? 'login',
          transitionOnUserGestures: true,
          child: ReusableRoundedButton(
            child: Text(
              label ?? 'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            // text: 'Login',
            onPressed: onPressed,
            height: 50,
            backgroundColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
