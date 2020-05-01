import 'package:flutter/material.dart';
import 'package:oureschoolweb/components/color.dart';
import 'package:oureschoolweb/components/typography.dart';

InputDecoration kTextFieldDecorationWithIcon(BuildContext context, {@required IconData icon}) => InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: new BorderSide(
          color: Colors.white,
          width: 3.5,
        ),
        gapPadding: 20,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: new BorderSide(
          color: textWithTransparency,
          width: 2,
        ),
        gapPadding: 20,
      ),
      hoverColor: Colors.redAccent,
      fillColor: Colors.white,
      prefixIcon:Icon(
        icon,
        color: Colors.white,
      ),
      labelStyle: bodyTextStyle(context, color: Colors.white),
      hintStyle: TextStyle(height: 1.5, fontWeight: FontWeight.w300),
      contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
    );
