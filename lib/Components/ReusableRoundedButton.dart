import 'package:flutter/material.dart';

import '../constants.dart';

class ReusableRoundedButton extends StatelessWidget {
  final Function onPressed;
  final double height;
  final Color backgroundColor;
  final Widget child;

  const ReusableRoundedButton(
      {@required this.onPressed,
      @required this.height,
      this.backgroundColor,
      @required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: 10,
      shape: kRoundedButtonShape,
      child: MaterialButton(
        height: height,
        // minWidth: 300,
        // elevation: 10,
        shape: kRoundedButtonShape,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
