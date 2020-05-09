import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oureschoolweb/ui/components/color.dart';
import 'package:oureschoolweb/ui/components/footer.dart';
import 'package:oureschoolweb/ui/components/logged_in_menubar/logged_In_menubar.dart';
import 'package:oureschoolweb/ui/components/resources.dart';
import 'package:oureschoolweb/ui/components/styles.dart';
import 'package:oureschoolweb/ui/components/text.dart';
import 'package:oureschoolweb/ui/components/typography.dart';
import 'package:oureschoolweb/ui/helper/Enums.dart';
import 'package:oureschoolweb/ui/pages/add_user/add_user_view_model.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

class AddUser extends StatelessWidget {
  const AddUser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: <Widget>[
            LogedInMenuBar(selectedPage: SelectedPage.ADDUSER),
            ResponsiveAddUserUI(),
            Footer(),
          ],
        ),
      ),
    ));
  }
}

class ResponsiveAddUserUI extends StatelessWidget {
  const ResponsiveAddUserUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.isDesktop) {
              // print("Desktop");
              return DesktopAddUserUI();
            }
            if (sizingInformation.isTablet) {
              // print("Tablet");
              // print(MediaQuery.of(context).size.width);
              return TabletAddUserUI();
            }
            if (sizingInformation.isMobile) {
              return MobileAddUserUI();
            }
            return DesktopAddUserUI();
          },
        );
      },
    );
  }
}

class MobileAddUserUI extends StatelessWidget {
  const MobileAddUserUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 600,
          child: Card(
            elevation: 10,
            color: kmainColorParents.withOpacity(0.7),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      ImageAssets.add_user2x,
                      fit: BoxFit.fitWidth,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Container(
                  child: AddUserForm(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DesktopAddUserUI extends StatelessWidget {
  const DesktopAddUserUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          flex: 8,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Card(
              elevation: 0,
              // color: Colors.blueGrey,
              child: Image.asset(
                ImageAssets.add_user2x,
                fit: BoxFit.fitWidth,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 12,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 600,
            child: Card(
              elevation: 10,
              color: kmainColorParents,
              child: AddUserForm(),
            ),
          ),
        ),
      ],
    );
  }
}

class TabletAddUserUI extends StatelessWidget {
  const TabletAddUserUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom: 10,
                    child: Image.asset(
                      ImageAssets.add_user2x,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 5,
          child: Container(
            height: 600,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 10,
              color: kmainColorParents,
              child: AddUserForm(),
            ),
          ),
        ),
      ],
    );
  }
}

class AddUserForm extends StatefulWidget {
  AddUserForm({
    Key key,
  }) : super(key: key);

  @override
  _AddUserFormState createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  String sharedValue = "Student";

  final _animatedListKey = GlobalKey<AnimatedListState>();
  List<Widget> parents = [];
  bool isLast = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddUserViewModel>.reactive(
        viewModelBuilder: () => AddUserViewModel(),
        builder: (context, model, child) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(
                    maxWidth: 400,
                    minWidth: 200,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextBodyExtraLarge(
                      text: "ADD USERS",
                      color: Colors.white,
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.all(10),
                //   constraints: BoxConstraints(
                //     maxWidth: 400,
                //     minWidth: 200,
                //     maxHeight: 100,
                //   ),
                //   child: CupertinoSlidingSegmentedControl<String>(
                //     onValueChanged: (String value) {
                //       setState(() {
                //         sharedValue = value;
                //       });
                //     },
                //     groupValue: sharedValue,
                //     children: {
                //       "Student": Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 30),
                //         child: Text(
                //           "Student",
                //           style: subtitleTextStyle(context),
                //         ),
                //       ),
                //       "Parent": Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 30),
                //         child: Text(
                //           "Parent",
                //           style: subtitleTextStyle(context),
                //         ),
                //       ),
                //       "Teacher": Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 30),
                //         child: Text(
                //           "Teacher",
                //           style: subtitleTextStyle(context),
                //         ),
                //       ),
                //     },
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(
                    maxWidth: 400,
                    minWidth: 200,
                  ),
                  child: TextField(
                    onChanged: (schoolCode) {},
                    keyboardType: TextInputType.text,
                    style: bodyTextStyle(context, color: Colors.white),
                    decoration: kTextFieldDecorationWithIcon(
                      context,
                      icon: Icons.alternate_email,
                    ).copyWith(
                      hintText: StringConstants.email_hint,
                      labelText: StringConstants.email,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(
                    maxWidth: 400,
                    minWidth: 200,
                  ),
                  child: TextField(
                    onChanged: (email) {},
                    keyboardType: TextInputType.emailAddress,
                    style: bodyTextStyle(context, color: Colors.white),
                    decoration: kTextFieldDecorationWithIcon(
                      context,
                      icon: Icons.enhanced_encryption,
                    ).copyWith(
                      hintText: "Genereated by system..",
                      labelText: "Id",
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    // color: Colors.red,
                    // padding: EdgeInsets.only(top: 8, left: 40),
                    constraints: BoxConstraints(
                      maxWidth: 400,
                      minWidth: 200,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 25,
                          top: 0,
                          // bottom: 0,
                          child: Container(
                            width: 2,
                            height: 120 *
                                (parents.length <= 1 ? 0 : parents.length - 1)
                                    .roundToDouble(),
                            color: Colors.white,
                          ),
                        ),
                        AnimatedList(
                          key: _animatedListKey,
                          itemBuilder: (context, index, animation) {
                            return SlideTransition(
                              position: animation.drive(Tween<Offset>(
                                  begin: Offset(0.0, 500.0), end: Offset.zero)),
                              child: parents[index],
                            );
                          },
                          // children: parents,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(
                      maxWidth: 400, minWidth: 200, minHeight: 70),
                  child: FlatButton(
                    hoverColor: Colors.redAccent.shade700,
                    color: Colors.redAccent,
                    onPressed: () {
                      isLast = true;
                      if (parents.length <= 4) {
                        parents.add(
                          parentDetailWidget(
                            context,
                            last: true,
                          ),
                        );
                        _animatedListKey.currentState
                            .insertItem(parents.length - 1);
                      }
                      setState(() {});
                    },
                    child: Center(
                      child: TextButton(
                        text: "Add User".toUpperCase(),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget parentDetailWidget(BuildContext context, {bool last = false}) {
    // isLast = last;
    return Stack(
      children: <Widget>[
        Positioned(
          left: 25,
          top: 0,
          bottom: last ? null : 0,
          child: Container(
            width: 2,
            height: 22,
            color: Colors.white,
          ),
        ),
        Positioned(
          left: 25,
          top: 22,
          // bottom: 0,
          child: Container(
            width: 17,
            height: 2,
            color: Colors.white,
          ),
        ),
        Positioned(
          left: 60,
          top: 52,
          // bottom: 40,
          child: Container(
            width: 2,
            height: 30,
            color: Colors.white,
          ),
        ),
        Positioned(
          left: 60,
          top: 80,
          // bottom: 0,
          child: Container(
            width: 20,
            height: 2,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0, left: 40, right: 10, top: 5),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (password) {},
                keyboardType: TextInputType.text,
                style: bodyTextStyle(context, color: Colors.white),
                decoration: kTextFieldDecorationWithIcon(context,
                    icon: parents.length == 0
                        ? Icons.looks_one
                        : parents.length == 1
                            ? Icons.looks_two
                            : parents.length == 2
                                ? Icons.looks_3
                                : parents.length == 3
                                    ? Icons.looks_4
                                    : parents.length == 4
                                        ? Icons.looks_5
                                        : Icons.looks_6,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    )).copyWith(
                  hintText: "Genereated by system..",
                  labelText: "Parent 1 id",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 0, top: 5),
                child: TextField(
                  onChanged: (password) {},
                  keyboardType: TextInputType.emailAddress,
                  style: bodyTextStyle(context, color: Colors.white),
                  decoration: kTextFieldDecorationWithIcon(context,
                      icon: Icons.alternate_email,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      )).copyWith(
                    hintText: StringConstants.email_hint,
                    labelText: StringConstants.email,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
