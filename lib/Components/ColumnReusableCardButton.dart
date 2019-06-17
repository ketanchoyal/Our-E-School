import 'package:flutter/material.dart';

class ColumnReusableCardButton extends StatelessWidget {

  final Function onPressed;
  final String label;
  final IconData icon;
  final double height;
  final IconData directionIcon;

  const ColumnReusableCardButton({
    @required this.onPressed,
    @required this.icon,
    @required this.label,
    this.height,
    this.directionIcon
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        height: height == null ? 80 : height,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              icon,
              size: 40,
              color: Colors.redAccent,
            ),
            Text(
              label,
              maxLines: 2,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
            Icon(
              directionIcon ?? Icons.chevron_right,
              size: 50,
            )
          ],
        ),
      ),
    );
  }
}
