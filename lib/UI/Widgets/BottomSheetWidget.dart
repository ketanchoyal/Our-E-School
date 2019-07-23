import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Utility/custom_icons.dart';
import 'package:ourESchool/UI/Widgets/ColumnReusableCardButton.dart';
import 'package:ourESchool/UI/pages/Dashboard/Announcement/AnnouncementPage.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/pages/Dashboard/E-Card/E-CardPage.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'RowReusableCardButton.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key key, this.user}) : super(key: key);

  final User user;

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 15),
        height: 150,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10, color: Colors.grey[300], spreadRadius: 5)
            ],
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ColumnReusableCardButton(
                  // height: 65,
                  tileColor: Colors.orangeAccent,
                  label: string.announcement,
                  icon: CustomIcons.megaphone,
                  onPressed: () {
                    kopenPage(
                      context,
                      AnnouncementPage(
                        announcementFor: widget.user.standard +
                            widget.user.division.toUpperCase(),
                      ),
                    );
                  },
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              Expanded(
                child: ColumnReusableCardButton(
                  // height: 65,
                  tileColor: Colors.deepOrangeAccent,
                  label: string.e_card,
                  onPressed: () {
                    kopenPage(
                        context,
                        ECardPage(
                          user: widget.user,
                        ));
                  },
                  icon: Icons.perm_contact_calendar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DecoratedTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration:
            InputDecoration.collapsed(hintText: 'Enter your reference number'),
      ),
    );
  }
}
