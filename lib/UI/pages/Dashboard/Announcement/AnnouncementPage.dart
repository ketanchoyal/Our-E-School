import 'package:ourESchool/imports.dart';

class AnnouncementPage extends StatefulWidget with AnalyticsScreen {
  AnnouncementPage({
    Key key,
    this.announcementFor = '',
  }) : super(key: key) {
    // setCurrentScreen();
  }

  final String announcementFor;

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();

  @override
  String get screenName => string.announcement + 'Page';
}

class _AnnouncementPageState extends State<AnnouncementPage>
    with AutomaticKeepAliveClientMixin {
  bool isTeacher = false;

  ScrollController controller;
  AnnouncementPageModel model = AnnouncementPageModel();
  String stdDiv_Global = 'Global';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLast = false;
  bool isLoaded = false;
  String buttonLabel = 'Global';

  TextEditingController _standardController = TextEditingController();
  TextEditingController _divisionController = TextEditingController();

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
    stdDiv_Global =
        widget.announcementFor == '' ? 'Global' : widget.announcementFor;
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
        model.getAnnouncements(stdDiv_Global);
        // scaffoldKey.currentState.widget
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var userType = Provider.of<UserType>(context, listen: false);
    AppUser currentUser = Provider.of<AppUser>(context, listen: false);
    if (userType == UserType.TEACHER) {
      isTeacher = true;
    } else if (userType == UserType.PARENT) {
    } else if (userType == UserType.STUDENT) {
      if (!isLoaded) {
        stdDiv_Global =
            currentUser.standard + currentUser.division.toUpperCase();
        isLoaded = true;
      }

      print(stdDiv_Global);
    }
    return BaseView<AnnouncementPageModel>(
        onModelReady: (model) => model.getAnnouncements(stdDiv_Global),
        builder: (context, model, child) {
          this.model = model;
          return Scaffold(
            key: scaffoldKey,
            appBar: TopBar(
                buttonHeroTag: string.announcement,
                title: stdDiv_Global + " Posts",
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
                        kopenPageSlide(context, CreateAnnouncement(),
                            duration: Duration(milliseconds: 200));
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
                    child: userType == UserType.STUDENT
                        ? FloatingActionButton.extended(
                            label: Text(buttonLabel),
                            heroTag: 'abc',
                            elevation: 12,
                            onPressed: () async {
                              if (stdDiv_Global == 'Global') {
                                setState(() {
                                  buttonLabel = stdDiv_Global;
                                  stdDiv_Global = currentUser.standard +
                                      currentUser.division.toUpperCase();
                                });
                              } else {
                                setState(() {
                                  buttonLabel = stdDiv_Global;
                                  stdDiv_Global = 'Global';
                                });
                              }

                              await model.onRefresh(stdDiv_Global);
                            },
                            icon: Icon(FontAwesomeIcons.globe),
                            backgroundColor: Colors.red,
                          )
                        : userType == UserType.TEACHER
                            ? FloatingActionButton.extended(
                                label: Text('Filter'),
                                heroTag: 'abc',
                                elevation: 12,
                                onPressed: () {
                                  //Filter Posts Code Here
                                  filterDialogBox(context, model);
                                },
                                icon: Icon(Icons.filter_list),
                                backgroundColor: Colors.red,
                              )
                            : Container(),
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
                  child: model.postSnapshotList.length == 0
                      ? model.state == ViewState.Busy
                          ? kBuzyPage(color: Theme.of(context).accentColor)
                          : Container(
                              child: Center(
                                child: Text(
                                  'No Posts available....!',
                                  style: ksubtitleStyle.copyWith(fontSize: 25),
                                ),
                              ),
                              // color: Colors.red,
                            )
                      : ListView.builder(
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
                                  opacity:
                                      model.state == ViewState.Busy ? 1.0 : 0.0,
                                  child: new SizedBox(
                                      width: 32.0,
                                      height: 32.0,
                                      child: kBuzyPage(
                                          color:
                                              Theme.of(context).accentColor)),
                                ),
                              );
                            }
                          },
                        ),
                  onRefresh: () async {
                    await model.onRefresh(stdDiv_Global);
                  },
                ),
              ),
            ),
          );
        });
  }

  Future filterDialogBox(BuildContext context, AnnouncementPageModel model) {
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
                  controller: _standardController,
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
                  controller: _divisionController,
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
                  child: Text('Global'.toUpperCase()),
                  onPressed: () async {
                    setState(() {
                      stdDiv_Global = 'Global';
                    });
                    await model.onRefresh(stdDiv_Global);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  child: Text(string.filter),
                  onPressed: () async {
                    setState(() {
                      stdDiv_Global = _standardController.text.trim() +
                          _divisionController.text.trim().toUpperCase();
                    });
                    await model.onRefresh(stdDiv_Global);
                    Navigator.pop(context);
                  },
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
