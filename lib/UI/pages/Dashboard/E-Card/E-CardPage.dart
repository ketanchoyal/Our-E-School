import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ourESchool/UI/pages/BaseView.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/viewmodel/ProfilePageModel.dart';

class ECardPage extends StatefulWidget {
  const ECardPage({Key key}) : super(key: key);

  @override
  _ECardPageState createState() => _ECardPageState();
}

class _ECardPageState extends State<ECardPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfilePageModel>(
        onModelReady: (model) => model.getUserProfileData(),
        builder: (context, model, child) {
          User user = model.userProfile;

          return Scaffold(
            appBar: TopBar(
              title: string.e_card,
              child: kBackBtn,
              onPressed: () {
                kbackBtn(context);
              },
            ),
            body: model.state == ViewState.Busy
                ? kBuzyPage(color: Theme.of(context).primaryColor)
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Container(
                              constraints:
                                  BoxConstraints(maxHeight: 200, maxWidth: 200),
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,r
                                image: DecorationImage(
                                  fit: BoxFit.scaleDown,
                                  image: model.userProfile.photoUrl != null
                                      ? NetworkImage(
                                          model.userProfile.photoUrl,
                                        )
                                      : NetworkImage(
                                          "https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png",
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              ProfileFieldsECard(
                                width: MediaQuery.of(context).size.width,
                                labelText: string.student_teacher_name,
                                initialText: user.displayName,
                              ),
                              ProfileFieldsECard(
                                width: MediaQuery.of(context).size.width,
                                labelText: string.student_or_teacher_id,
                                initialText: user.enrollNo,
                              ),
                              Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: ProfileFieldsECard(
                                      labelText: string.standard,
                                      initialText: user.standard,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ProfileFieldsECard(
                                      labelText: string.division,
                                      initialText: user.division.toUpperCase(),
                                    ),
                                  ),
                                ],
                              ),
                              ProfileFieldsECard(
                                width: MediaQuery.of(context).size.width,
                                labelText: string.guardian_name,
                                initialText: user.guardianName,
                              ),
                              Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: ProfileFieldsECard(
                                      labelText: string.dob,
                                      initialText: user.dob,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ProfileFieldsECard(
                                      labelText: string.blood_group,
                                      initialText: user.bloodGroup,
                                    ),
                                  ),
                                ],
                              ),
                              ProfileFieldsECard(
                                width: MediaQuery.of(context).size.width,
                                labelText: string.mobile_no,
                                initialText: user.mobileNo,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}

class ProfileFieldsECard extends StatelessWidget {
  final String initialText;
  final String labelText;
  final double width;

  const ProfileFieldsECard(
      {this.initialText, @required this.labelText, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      // width: width == null ? MediaQuery.of(context).size.width / 2.5 : width,
      child: TextField(
        enabled: false,
        controller: TextEditingController(text: initialText),
        keyboardType: TextInputType.text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: kTextFieldDecoration.copyWith(
          // hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
