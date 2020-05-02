import 'package:flutter/material.dart';

class RowReusableCardButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String label;
  final Color tileColor;

  const RowReusableCardButton(
      {@required this.icon, @required this.label, @required this.onPressed, @required this.tileColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(maxWidth: 200),
      color: tileColor ?? Colors.amber,
      child: new _ReusableMaterialButton(onPressed: onPressed, icon: icon, label: label),
    );
  }
}

class RowReusableCardButtonBanner extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String label;
  final Color tileColor;
  final double paddingTop;

  const RowReusableCardButtonBanner(
      {@required this.icon, @required this.label, @required this.onPressed, @required this.tileColor, this.paddingTop = 5.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop, bottom: 0, right: 5),
      child: ClipRect(
        child: Container(
          color: tileColor ?? Colors.blue,
          child: Banner(
            location: BannerLocation.topStart,
            message: 'Premium',
            child: new _ReusableMaterialButton(onPressed: onPressed, icon: icon, label: label),
          ),
        ),
      ),
    );
  }
}

class _ReusableMaterialButton extends StatelessWidget {
  const _ReusableMaterialButton({
    Key key,
    @required this.onPressed,
    @required this.icon,
    @required this.label,
  }) : super(key: key);

  final Function onPressed;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // constraints: BoxConstraints(),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width / 2 - 13,
        onPressed: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}