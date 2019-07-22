import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/AnnouncementCard.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/pages/Login/LoginPage.dart';
import 'package:ourESchool/core/Models/Announcement.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/enums/announcementType.dart';
import 'package:provider/provider.dart';

import 'CreateAnnouncement.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key key}) : super(key: key);

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  bool isTeacher = false;

  String url =
      'https://i1.rgstatic.net/publication/274400281_Adult_male_circumcision_with_a_circular_stapler_versus_conventional_circumcision_A_prospective_randomized_clinical_trial/links/5599d54708ae793d13805d4f/largepreview.png';

  String randomText =
      '''When using any kind of state management strategy how should I handle exceptions?
I’m confused if they’re business logic or UI logic.
For example:
I want to perform login and call a function for that, this function can either return a token or raise an exception, depending on the case my UI will display different information. Should I handle the exception in my business logic and convert it to a state or should I handle it in the UI?''';

  ScrollController controller;
  DocumentSnapshot _lastPost;
  Firestore firestore;
  bool _isLoading;
  CollectionReference get postFeed => firestore
      .collection('Schools')
      .document('India')
      .collection('AMBE001')
      .document('Posts')
      .collection('9B');
  List<DocumentSnapshot> _data = new List<DocumentSnapshot>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    firestore = Firestore.instance;
    controller = new ScrollController()..addListener(_scrollListener);
    super.initState();
    _isLoading = true;
    _getData();
  }

  Future<Null> _getData() async {
//    await new Future.delayed(new Duration(seconds: 5));
    QuerySnapshot data;
    if (_lastPost == null)
      data = await postFeed
          .orderBy('timeStamp', descending: true)
          .limit(3)
          .getDocuments();
    else
      data = await postFeed
          .orderBy('timeStamp', descending: true)
          .startAfter([_lastPost['timeStamp']])
          .limit(3)
          .getDocuments();

    if (data != null && data.documents.length > 0) {
      _lastPost = data.documents[data.documents.length - 1];
      if (mounted) {
        setState(() {
          _isLoading = false;
          _data.addAll(data.documents);
        });
      }
    } else {
      setState(() => _isLoading = false);
      scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('No more posts!'),
        ),
      );
    }
    return null;
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (!_isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        setState(() => _isLoading = true);
        _getData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var userType = Provider.of<UserType>(context);
    if (userType == UserType.TEACHER) {
      isTeacher = true;
    }
    return Scaffold(
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
                      onPressed: () {},
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
              controller: controller,
              itemCount: _data.length + 1,
              itemBuilder: (context, index) {
                if (index < _data.length) {
                  return AnnouncementCard(
                      announcement: Announcement.fromSnapshot(_data[index]));
                } else {
                  return Center(
                    child: new Opacity(
                      opacity: _isLoading ? 1.0 : 0.0,
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
              _data.clear();
              _lastPost = null;
              await _getData();
            },
          ),
        ),
      ),
    );
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
}
