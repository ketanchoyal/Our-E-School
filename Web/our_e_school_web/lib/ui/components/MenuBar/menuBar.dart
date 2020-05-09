import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oureschoolweb/ui/components/color.dart';
import 'package:oureschoolweb/ui/components/menubar/menuBar_model.dart';
import 'package:oureschoolweb/ui/components/typography.dart';
import 'package:oureschoolweb/ui/helper/Enums.dart';
import 'package:stacked/stacked.dart';

class MenuBar extends StatelessWidget {
  MenuBar({@required this.selectedPage});
  // final NavigationService _navigationService = locator<NavigationService>();

  final SelectedPage selectedPage;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MenuBarModel>.reactive(
        viewModelBuilder: () => MenuBarModel(),
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
                          model.navigateToHome(),
                      child: Text("OUR E-SCHOOL",
                          style: GoogleFonts.montserrat(
                              color:textMenuBarPrimary,
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
                              elevation:
                                  selectedPage == SelectedPage.LOGIN ? 10 : 0,
                              color: Colors.transparent,
                              child: FlatButton(
                                onPressed: () => model.navigateToLogin(),
                                child: Text(
                                  "LOGIN",
                                  style: buttonTextStyle(),
                                ),
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                            ),
                            Card(
                              elevation: selectedPage == SelectedPage.REGISTER
                                  ? 10
                                  : 0,
                              color: Colors.transparent,
                              child: FlatButton(
                                onPressed: () => model.navigateToRegister(),
                                child: Text(
                                  "REGISTER",
                                  style: buttonTextStyle(),
                                ),
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                            ),
                            Card(
                              elevation:
                                  selectedPage == SelectedPage.ABOUT ? 10 : 0,
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
                                  selectedPage == SelectedPage.CONTACT ? 10 : 0,
                              color: Colors.transparent,
                              child: FlatButton(
                                onPressed: () {},
                                child: Text(
                                  "CONTACT",
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
        });
  }
}
