import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

class MainButton extends StatelessWidget {
  final Function onPressed;

  const MainButton({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hover = false;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return MouseRegion(
        onHover: (event) => setState(() => hover = true),
        onExit: (event) => setState(() => hover = false),
        child: OutlineButton(
          onPressed: onPressed,
          highlightedBorderColor: textMenuBarPrimary,
          hoverColor: textMenuBarPrimary,
          borderSide: BorderSide(color: textMenuBarPrimary, width: 2),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "READ MORE",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                  fontSize: 14,
                  color: hover ? Colors.white : textMenuBarPrimary,
                  letterSpacing: 1),
            ),
          ),
        ),
      );
    });
  }
}