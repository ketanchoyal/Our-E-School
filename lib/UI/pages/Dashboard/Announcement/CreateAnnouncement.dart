import 'package:ourESchool/imports.dart';

class CreateAnnouncement extends StatefulWidget {
  CreateAnnouncement({Key key}) : super(key: key);

  _CreateAnnouncementState createState() => _CreateAnnouncementState();
}

class _CreateAnnouncementState extends State<CreateAnnouncement> {
  String path = '';

  TextEditingController _standardController;
  TextEditingController _divisionController;
  TextEditingController _captionController;

  AnnouncementType announcementType = AnnouncementType.EVENT;

  FocusNode _focusNode = new FocusNode();
  var _scaffoldKey;
  bool isPosting = false;
  Color postTypeFontColor = Colors.black;
  bool isReadyToPost = false;
  String postType = 'GLOBAL';

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _standardController = TextEditingController();
    _captionController = TextEditingController();
    _divisionController = TextEditingController();
  }

  floatingButtonPressed(
      CreateAnnouncementModel model, BuildContext context) async {
    AppUser user = Provider.of<AppUser>(context, listen: false);
    var announcement = Announcement(
      by: user.id,
      caption: _captionController.text,
      forClass:
          postType == 'SPECIFIC' ? _standardController.text.trim() : 'Global',
      forDiv: postType == 'SPECIFIC'
          ? _divisionController.text.toUpperCase().trim()
          : 'Global',
      photoUrl: path,
      type: announcementType,
    );
    if (postType == 'SPECIFIC') {
      if (_standardController.text.trim() == '' ||
          _divisionController.text.trim() == '') {
        _scaffoldKey.currentState.showSnackBar(
            ksnackBar(context, 'Please Specify Class and Division'));
      } else {
        await model.postAnnouncement(announcement);
        kbackBtn(context);
      }
    } else {
      await model.postAnnouncement(announcement);
      kbackBtn(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    postTypeFontColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return BaseView<CreateAnnouncementModel>(
      onModelReady: (model) => model.getUserData(),
      builder: (context, model, child) {
        isPosting = model.state == ViewState.Idle ? false : true;
        return Scaffold(
          key: _scaffoldKey,
          appBar: TopBar(
            onTitleTapped: () {},
            child: kBackBtn,
            onPressed: () {
              if (!isPosting) kbackBtn(context);
            },
            title: string.create_post,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (isReadyToPost) floatingButtonPressed(model, context);
            },
            backgroundColor: isReadyToPost
                ? Theme.of(context).primaryColor
                : Colors.blueGrey,
            child: model.state == ViewState.Busy
                ? SpinKitDoubleBounce(
                    color: Colors.white,
                    size: 20,
                  )
                : Icon(Icons.check),
          ),
          body: InkWell(
            // splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              _focusNode.unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      // height: 165,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              string.this_post_is_for,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: RawMaterialButton(
                                    elevation: 0,
                                    constraints: BoxConstraints(minHeight: 50),
                                    child: Text(
                                      'GLOBAL POST',
                                      style: TextStyle(
                                        color: postType == 'GLOBAL'
                                            ? Colors.white
                                            : postTypeFontColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        postType = 'GLOBAL';
                                      });
                                    },
                                    fillColor: postType == 'GLOBAL'
                                        ? Theme.of(context).primaryColor
                                        : Colors.transparent,
                                  ),
                                ),
                                Expanded(
                                  child: RawMaterialButton(
                                    elevation: 0,
                                    constraints: BoxConstraints(minHeight: 50),
                                    child: Text(
                                      'SPECIFIC',
                                      style: TextStyle(
                                        color: postType == 'SPECIFIC'
                                            ? Colors.white
                                            : postTypeFontColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        postType = 'SPECIFIC';
                                      });
                                    },
                                    fillColor: postType == 'SPECIFIC'
                                        ? Theme.of(context).primaryColor
                                        : Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          postType == 'SPECIFIC'
                              ? SizedBox(
                                  height: 5,
                                )
                              : Container(),
                          postType == 'SPECIFIC'
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      // width: MediaQuery.of(context).size.width / 2.2,
                                      child: TextField(
                                        enabled: !isPosting,
                                        controller: _standardController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        decoration:
                                            kTextFieldDecoration.copyWith(
                                          hintText: string.standard_hint,
                                          labelText: string.standard,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      // width: MediaQuery.of(context).size.width / 2.2,
                                      child: TextField(
                                        enabled: !isPosting,
                                        controller: _divisionController,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        decoration:
                                            kTextFieldDecoration.copyWith(
                                          hintText: string.division_hint,
                                          labelText: string.division,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    postType == 'SPECIFIC'
                        ? SizedBox(
                            height: 5,
                          )
                        : Container(),
                    Container(
                      // height: 60,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              child: Text(
                                'EVENT',
                                style: TextStyle(
                                  color:
                                      announcementType == AnnouncementType.EVENT
                                          ? Colors.white
                                          : postTypeFontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (model.state == ViewState.Idle)
                                    announcementType = AnnouncementType.EVENT;
                                });
                              },
                              color: announcementType == AnnouncementType.EVENT
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              child: Text(
                                'CIRCULAR',
                                style: TextStyle(
                                  color: announcementType ==
                                          AnnouncementType.CIRCULAR
                                      ? Colors.white
                                      : postTypeFontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (model.state == ViewState.Idle)
                                    announcementType =
                                        AnnouncementType.CIRCULAR;
                                });
                              },
                              color:
                                  announcementType == AnnouncementType.CIRCULAR
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              child: Text(
                                'ACTIVITY',
                                style: TextStyle(
                                  color: announcementType ==
                                          AnnouncementType.ACTIVITY
                                      ? Colors.white
                                      : postTypeFontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (model.state == ViewState.Idle)
                                    announcementType =
                                        AnnouncementType.ACTIVITY;
                                });
                              },
                              color:
                                  announcementType == AnnouncementType.ACTIVITY
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxHeight: 300, minHeight: 0),
                      child: path == ''
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                MaterialButton(
                                  height: 100,
                                  minWidth:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Icon(FontAwesomeIcons.camera),
                                  onPressed: () async {
                                    Future<String> path =
                                        Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => CameraScreen()),
                                    );
                                    path.then((path) {
                                      if (path != null)
                                        setState(() {
                                          this.path = path;
                                        });
                                      print('Path' + path);
                                    });
                                  },
                                ),
                                MaterialButton(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 2.2,
                                  height: 100,
                                  child: Icon(Icons.photo_library),
                                  onPressed: () async {
                                    String _path = await openFileExplorer(
                                      FileType.image,
                                      mounted,
                                      context,
                                    );
                                    if (_path != null)
                                      setState(() {
                                        path = _path;
                                      });
                                  },
                                ),
                              ],
                            )
                          : Card(
                              elevation: 4,
                              child: Container(
                                // constraints:
                                //     BoxConstraints(maxHeight: 300, minHeight: 0),
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Image(
                                      fit: BoxFit.contain,
                                      image: FileImage(
                                        File(path),
                                      ),
                                    ),
                                    Positioned(
                                      right: -0,
                                      bottom: -0,
                                      child: Card(
                                        elevation: 10,
                                        shape: kCardCircularShape,
                                        child: MaterialButton(
                                          minWidth: 20,
                                          height: 10,
                                          onPressed: () {
                                            setState(
                                              () {
                                                path = '';
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 150,
                      // color: Colors.blueAccent.withOpacity(0.5),
                      child: TextField(
                        controller: _captionController,
                        enabled: !isPosting,
                        focusNode: _focusNode,
                        maxLength: null,
                        onChanged: (caption) {
                          setState(() {
                            isReadyToPost = caption == '' ? false : true;
                          });
                        },
                        maxLines: 50,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: string.type_your_stuff_here,
                          labelText: string.caption,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
