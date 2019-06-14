import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';

class ReusableRoundedButton extends StatelessWidget {
  final Function onPressed;
  final double height;
  final Color backgroundColor;
  final Widget child;

  const ReusableRoundedButton(
      {@required this.onPressed,
      this.height,
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
