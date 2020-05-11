import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:oureschoolweb/ui/components/color.dart';
import 'package:oureschoolweb/ui/components/footer.dart';
import 'package:oureschoolweb/ui/components/logged_in_menubar/logged_In_menubar.dart';
import 'package:oureschoolweb/ui/components/resources.dart';
import 'package:oureschoolweb/ui/components/styles.dart';
import 'package:oureschoolweb/ui/components/text.dart';
import 'package:oureschoolweb/ui/components/typography.dart';
import 'package:oureschoolweb/ui/helper/Enums.dart';
import 'package:oureschoolweb/ui/pages/add_user/add_user_view_model.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
        if (ResponsiveWrapper.of(context).equals(MOBILE) ||
            ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
          return MobileAddUserUI();
        } else if (ResponsiveWrapper.of(context).equals(TABLET)) {
          return TabletAddUserUI();
        } else {
          return DesktopAddUserUI();
        }
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
  int sharedValue = 0;

  ///animatedlist key of animatelist for adding parent while adding student
  final animatedParentListKey = GlobalKey<AnimatedListState>();

  ///animatedlist key of animatelist for adding children while adding parent
  final animatedChildListKey = GlobalKey<AnimatedListState>();
  List<Widget> addUserType = [];

  //list of parent to add with student
  List<Widget> parents = [];

  //list of childrens to add with parent
  List<Widget> childrens = [];
  bool isLast = false;
  int parentListIndex = 0;
  int childListIndex = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      parents.add(addParentButton());
      childrens.add(addChildButton());
      addUserType.add(addStudent(context));
      addUserType.add(addParent(context));
      addUserType.add(addTeacher(context));
      setState(() {});
    });
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
                Container(
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(
                    maxWidth: 400,
                    minWidth: 220,
                    maxHeight: 100,
                  ),
                  child: CupertinoSlidingSegmentedControl<int>(
                    onValueChanged: (int value) {
                      sharedValue = value;
                      setState(() {});
                    },
                    groupValue: sharedValue,
                    children: {
                      0: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "Student",
                          style: subtitleTextStyle(context),
                        ),
                      ),
                      1: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "Parent",
                          style: subtitleTextStyle(context),
                        ),
                      ),
                      2: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "Teacher",
                          style: subtitleTextStyle(context),
                        ),
                      ),
                    },
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      // addParent(context)
                      addUserType.isNotEmpty
                          ? addUserType[sharedValue]
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  ///Widget to add Student
  Column addStudent(BuildContext context) {
    return Column(
      children: <Widget>[
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
          padding: EdgeInsets.symmetric(horizontal: 10),
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
            constraints: BoxConstraints(
              maxWidth: 400,
              minWidth: 200,
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 25,
                  top: 0,
                  bottom: parentListIndex == 0 ? null : 0,
                  child: Container(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
                AnimatedList(
                  initialItemCount: parents.length,
                  key: animatedParentListKey,
                  itemBuilder: (context, index, animation) {
                    return buildItem(context, index, animation, parents);
                  },
                  // children: parents,
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          constraints: BoxConstraints(
            maxWidth: 400,
            minWidth: 200,
            minHeight: 70,
          ),
          child: MaterialButton(
            hoverColor: Colors.redAccent.shade700,
            color: Colors.redAccent,
            autofocus: true,
            onPressed: () {},
            child: Center(
              child: TextButton(
                text: "Add Student".toUpperCase(),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///Widget to add Teacher
  Column addTeacher(BuildContext context) {
    return Column(
      children: <Widget>[
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
          padding: EdgeInsets.symmetric(horizontal: 10),
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
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(vertical: 40),
          constraints: BoxConstraints(
            maxWidth: 400,
            minWidth: 200,
            minHeight: 70,
          ),
          child: MaterialButton(
            hoverColor: Colors.redAccent.shade700,
            color: Colors.redAccent,
            autofocus: true,
            onPressed: () {},
            child: Center(
              child: TextButton(
                text: "Add Teacher".toUpperCase(),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///Widget to add parent
  Column addParent(BuildContext context) {
    return Column(
      children: <Widget>[
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
          padding: EdgeInsets.symmetric(horizontal: 10),
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
            constraints: BoxConstraints(
              maxWidth: 400,
              minWidth: 200,
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 25,
                  top: 0,
                  bottom: childListIndex == 0 ? null : 0,
                  child: Container(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
                AnimatedList(
                  initialItemCount: childrens.length,
                  key: animatedChildListKey,
                  itemBuilder: (context, index, animation) {
                    return buildItem(context, index, animation, childrens);
                  },
                  // children: parents,
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          constraints: BoxConstraints(
            maxWidth: 400,
            minWidth: 200,
            minHeight: 70,
          ),
          child: MaterialButton(
            hoverColor: Colors.redAccent.shade700,
            color: Colors.redAccent,
            autofocus: true,
            onPressed: () {},
            child: Center(
              child: TextButton(
                text: "Add Parent".toUpperCase(),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

// add parent button (in add student section)
  Widget addParentButton() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      constraints: BoxConstraints(maxWidth: 300, minWidth: 150, minHeight: 55),
      child: FlatButton(
        hoverColor: Colors.redAccent.shade700,
        color: Colors.redAccent.withOpacity(0.6),
        onPressed: () {
          isLast = true;
          if (parentListIndex <= 3) {
            parents.insert(
              parents.length - 1,
              parentDetailWidget(
                context,
                ++parentListIndex,
                last: true,
              ),
            );
            animatedParentListKey.currentState.insertItem(parents.length - 2);
          }
          setState(() {});
        },
        child: Center(
          child: TextButton(
            text: "Add Parent".toUpperCase(),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

// add child button (in add parent section)
  Widget addChildButton() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      constraints: BoxConstraints(maxWidth: 300, minWidth: 150, minHeight: 55),
      child: FlatButton(
        hoverColor: Colors.redAccent.shade700,
        color: Colors.redAccent.withOpacity(0.6),
        onPressed: () {
          isLast = true;
          if (childListIndex <= 4) {
            childrens.insert(
              childrens.length - 1,
              childDetailWidget(
                context,
                ++childListIndex,
                last: true,
              ),
            );
            animatedChildListKey.currentState.insertItem(childrens.length - 2);
          }
          setState(() {});
        },
        child: Center(
          child: TextButton(
            text: "Add Child".toUpperCase(),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, int index, Animation<double> animation,
      List<Widget> widgetList) {
    return SlideTransition(
      position: animation
          .drive(Tween<Offset>(begin: Offset(0.0, 500.0), end: Offset.zero)),
      child: widgetList[index],
    );
  }

//widget to add parent email-id while adding student
  Widget parentDetailWidget(BuildContext context, int index,
      {bool last = false}) {
    // isLast = last;
    print(index);
    return Stack(
      children: <Widget>[
        Positioned(
          left: 25,
          top: 28,
          child: Container(
            width: 17,
            height: 2,
            color: Colors.white,
          ),
        ),
        Positioned(
          left: 22,
          top: 25,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          left: 60,
          top: 53,
          // bottom: 40,
          child: Container(
            width: 2,
            height: 27,
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
        Positioned(
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(right: 0, top: 10),
            child: Container(
              height: 50,
              width: 50,
              child: FlatButton(
                onPressed: () {
                  // int removeAt = index - 1;
                  parents.removeAt(index);
                  AnimatedListRemovedItemBuilder builder =
                      (context, animation) {
                    return buildItem(context, index + 1, animation, parents);
                  };
                  animatedParentListKey.currentState.removeItem(index,
                      (context, animation) => builder(context, animation));
                  parentListIndex--;
                  // setState(() {});
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Icon(
                  Icons.remove_circle,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5.0, left: 40, right: 55, top: 5),
          child: Column(
            children: <Widget>[
              TextField(
                controller: TextEditingController(text: index.toString()),
                onChanged: (password) {},
                keyboardType: TextInputType.text,
                style: bodyTextStyle(context, color: Colors.white),
                decoration: kTextFieldDecorationWithIcon(context,
                    icon: parents.length == 1
                        ? Icons.looks_one
                        : parents.length == 2
                            ? Icons.looks_two
                            : parents.length == 3
                                ? Icons.looks_3
                                : parents.length == 4
                                    ? Icons.looks_4
                                    : parents.length == 5
                                        ? Icons.looks_5
                                        : Icons.looks_6,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    )).copyWith(
                  hintText: "Genereated by system..",
                  labelText: "Parent " + index.toString() + " id",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 0, top: 5),
                child: TextField(
                  onChanged: (password) {},
                  controller:
                      TextEditingController(text: parents.length.toString()),
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

//widget to add parent email-id while adding student
  Widget childDetailWidget(BuildContext context, int index,
      {bool last = false}) {
    // isLast = last;
    // print(index);
    return Stack(
      children: <Widget>[
        Positioned(
          left: 25,
          top: 28,
          child: Container(
            width: 17,
            height: 2,
            color: Colors.white,
          ),
        ),
        Positioned(
          left: 22,
          top: 25,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          left: 60,
          top: 53,
          // bottom: 40,
          child: Container(
            width: 2,
            height: 27,
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
        Positioned(
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(right: 0, top: 10),
            child: Container(
              height: 50,
              width: 50,
              child: FlatButton(
                onPressed: () {
                  // int removeAt = index - 1;
                  childrens.removeAt(index);
                  AnimatedListRemovedItemBuilder builder =
                      (context, animation) {
                    return buildItem(context, index + 1, animation, childrens);
                  };
                  animatedChildListKey.currentState.removeItem(index,
                      (context, animation) => builder(context, animation));
                  childListIndex--;
                  // setState(() {});
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Icon(
                  Icons.remove_circle,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5.0, left: 40, right: 55, top: 5),
          child: Column(
            children: <Widget>[
              TextField(
                controller: TextEditingController(text: index.toString()),
                onChanged: (password) {},
                keyboardType: TextInputType.text,
                style: bodyTextStyle(context, color: Colors.white),
                decoration: kTextFieldDecorationWithIcon(context,
                    icon: childrens.length == 1
                        ? Icons.looks_one
                        : childrens.length == 2
                            ? Icons.looks_two
                            : childrens.length == 3
                                ? Icons.looks_3
                                : childrens.length == 4
                                    ? Icons.looks_4
                                    : childrens.length == 5
                                        ? Icons.looks_5
                                        : Icons.looks_6,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    )).copyWith(
                  hintText: "Genereated by system..",
                  labelText: "Child " + index.toString() + " id",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 0, top: 5),
                child: TextField(
                  onChanged: (password) {},
                  controller:
                      TextEditingController(text: childrens.length.toString()),
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
