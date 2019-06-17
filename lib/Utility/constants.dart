import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var kTextFieldDecoration = InputDecoration(
  // hintText: 'Enter your password.',
  // labelText: 'Email',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  hintStyle: TextStyle(
      height: 1.5,
      fontWeight: FontWeight.w300),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
);

String kFontFamily = 'Nunito';

TextStyle ktitleStyle = TextStyle(fontWeight: FontWeight.w800);
TextStyle ksubtitleStyle = TextStyle(fontWeight: FontWeight.w600);

Color kmainColorTeacher = Color.fromRGBO(254, 198, 27, 1.0);
Color kmainColorStudents = Color.fromRGBO(244, 163, 52, 1.0);
Color kmainColorParents = Color.fromRGBO(249, 202, 36, 1.0);

ShapeBorder kRoundedButtonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(50)),
);

ShapeBorder kBackButtonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30),
  ),
);

// CircleBorder kCardCircularShape = CircleBorder(
//   side: BorderSide(width: 1),
// );

ShapeBorder kCardCircularShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(50)),
);

Widget kBackBtn = Icon(
  Icons.arrow_back_ios,
  // color: Colors.black54,
);

kopenPage(BuildContext context, Widget page) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => page,
    ),
  );
}

kbackBtn(BuildContext context) {
  Navigator.of(context).pop();
}

kopenPageBottom(BuildContext context, Widget page) {
  Navigator.of(context).push(
    CupertinoPageRoute<bool>(
      fullscreenDialog: true,
      builder: (BuildContext context) => page,
    ),
  );
}
