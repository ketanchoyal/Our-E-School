import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oureschoolweb/ui/components/color.dart';
import 'package:oureschoolweb/ui/components/logged_in_menubar/logged_in_menubar_model.dart';
import 'package:oureschoolweb/ui/components/typography.dart';
import 'package:oureschoolweb/ui/helper/Enums.dart';
import 'package:stacked/stacked.dart';

class LogedInMenuBar extends StatelessWidget {
  LogedInMenuBar({@required this.selectedPage});

  final SelectedPage selectedPage;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoggedInMenuBarModel>.reactive(
        viewModelBuilder: () => LoggedInMenuBarModel(),
        builder: (context, model, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () =>
                        Navigator.popUntil(context, ModalRoute.withName("/")),
                    child: Text("OUR E-SCHOOL",
                        style: GoogleFonts.montserrat(
                            color: textMenuBarPrimary,
                            fontSize: 30,
                            letterSpacing: 3,
                            fontWeight: FontWeight.w500)),
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        children: <Widget>[
                          Card(
                            elevation: selectedPage == SelectedPage.ADDUSER ? 10 : 0,
                            color: Colors.transparent,
                            child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "USERNAME",
                                style: buttonTextStyle(),
                              ),
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                          ),
                          Card(
                            elevation:
                                selectedPage == SelectedPage.PROFILE ? 10 : 0,
                            color: Colors.transparent,
                            child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "PROFILE",
                                style: buttonTextStyle(),
                              ),
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                          ),
                          Card(
                            elevation: selectedPage == SelectedPage.ABOUT ? 10 : 0,
                            color: Colors.transparent,
                            child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "ABOUT",
                                style: buttonTextStyle(),
                              ),
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                          ),
                          Card(
                            elevation:
                                selectedPage == SelectedPage.LOGOUT ? 10 : 0,
                            color: Colors.transparent,
                            child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "LOGOUT",
                                style: buttonTextStyle(),
                              ),
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 1,
                margin: EdgeInsets.only(bottom: 30),
                color: Color(0xFFEEEEEE)),
          ],
        );
      }
    );
  }
}
