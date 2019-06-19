import 'package:flutter/material.dart';

class ColumnReusableCardButton extends StatelessWidget {

  final Function onPressed;
  final String label;
  final IconData icon;
  final double height;
  final IconData directionIcon;
  final Color tileColor;
  // final double elevation;

  const ColumnReusableCardButton({
    @required this.onPressed,
    @required this.icon,
    @required this.label,
    @required this.tileColor,
    this.height,
    this.directionIcon,
    // this.elevation
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        color: tileColor ?? Colors.green,
        // elevation: elevation ?? 4,
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
                color: Colors.white,
              ),
              Text(
                label,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600
                ),
              ),
              Icon(
                directionIcon ?? Icons.chevron_right,
                color: Colors.white,
                size: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
