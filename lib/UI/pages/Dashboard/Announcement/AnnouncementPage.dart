import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/AnnouncementCard.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/pages/BaseView.dart';
import 'package:ourESchool/UI/pages/Login/LoginPage.dart';
import 'package:ourESchool/core/Models/Announcement.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/enums/announcementType.dart';
import 'package:ourESchool/core/viewmodel/AnnouncementPageModel.dart';
import 'package:provider/provider.dart';

import 'CreateAnnouncement.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key key}) : super(key: key);

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage>
    with AutomaticKeepAliveClientMixin {
  bool isTeacher = false;

  ScrollController controller;
  AnnouncementPageModel model = AnnouncementPageModel();
  String stdDiv_Global = 'Global';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLast = false;

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (model.state == ViewState.Idle) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        // setState(() => _isLoading = true);
        model.getAnnouncements(stdDiv_Global, scaffoldKey);
        // scaffoldKey.currentState.widget
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var userType = Provider.of<UserType>(context);
    if (userType == UserType.TEACHER) {
      isTeacher = true;
    }
    stdDiv_Global = '9B';
    return BaseView<AnnouncementPageModel>(
        onModelReady: (model) =>
            model.getAnnouncements(stdDiv_Global, scaffoldKey),
        builder: (context, model, child) {
          this.model = model;
          return Scaffold(
            key: scaffoldKey,
            appBar: TopBar(
                title: string.announcement,
                child: kBackBtn,
                onPressed: () {
                  kbackBtn(context);
                }),
            // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: Stack(
              children: <Widget>[
                Visibility(
                  visible: isTeacher,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      elevation: 12,
                      onPressed: () {
                        kopenPageBottom(context, CreateAnnouncement());
                      },
                      child: Icon(Icons.add),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 31),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: isTeacher
                        ? FloatingActionButton.extended(
                            label: Text('Filter'),
                            heroTag: 'abc',
                            elevation: 12,
                            onPressed: () {
                              //Filter Posts Code Here
                              filterDialogBox(context);
                            },
                            icon: Icon(Icons.filter_list),
                            backgroundColor: Colors.red,
                          )
                        : FloatingActionButton.extended(
                            label: Text('Global'),
                            heroTag: 'abc',
                            elevation: 12,
                            onPressed: () {
                              stdDiv_Global = 'Global';
                              setState(() {});
                            },
                            icon: Icon(FontAwesomeIcons.globe),
                            backgroundColor: Colors.red,
                          ),
                  ),
                ),
              ],
            ),
            body: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 700,
                ),
                child: RefreshIndicator(
                  child: ListView.builder(
                    addAutomaticKeepAlives: true,
                    cacheExtent: 10,
                    controller: controller,
                    itemCount: model.postSnapshotList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < model.postSnapshotList.length) {
                        return AnnouncementCard(
                            announcement: Announcement.fromSnapshot(
                                model.postSnapshotList[index]));
                      } else {
                        return Center(
                          child: new Opacity(
                            opacity: model.state == ViewState.Busy ? 1.0 : 0.0,
                            child: new SizedBox(
                                width: 32.0,
                                height: 32.0,
                                child: new CircularProgressIndicator()),
                          ),
                        );
                      }
                    },
                  ),
                  onRefresh: () async {
                    await model.onRefresh(stdDiv_Global, scaffoldKey);
                  },
                ),
              ),
            ),
          );
        });
  }

  Future filterDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            string.show_announcement_of,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                string.filter_announcement,
                // style: TextStyle(fontFamily: 'Subtitle'),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  onChanged: (standard) {},
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  // decoration: InputDecoration(
                  //     hintText: "Master Pass",
                  //     hintStyle: TextStyle(fontFamily: "Subtitle"),
                  //     ),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: string.standard_hint,
                    labelText: string.standard,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  onChanged: (division) {},
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: string.division_hint,
                    labelText: string.division,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text(string.cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  child: Text(string.filter),
                  onPressed: () {},
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
