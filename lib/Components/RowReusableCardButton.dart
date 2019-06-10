import 'package:flutter/material.dart';

class RowReusableCardButton extends StatelessWidget {

  final Function onPressed;
  final IconData icon;
  final String label;
  
  const RowReusableCardButton({
    @required this.icon,
    @required this.label,
    @required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width / 2 - 20,
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon,
              size: 40,
              color: Colors.redAccent,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
      ),
    );
  }
}
