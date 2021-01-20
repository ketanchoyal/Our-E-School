import 'package:ourESchool/UI/Widgets/AssignmentBottomSheet.dart';
import 'package:ourESchool/UI/Widgets/AssignmentDetailBottomSheet.dart';
import 'package:ourESchool/imports.dart';

class AssignmentsPage extends StatefulWidget with AnalyticsScreen {
  AssignmentsPage({Key key, this.standard = ''}) : super(key: key) {
    // setCurrentScreen();
  }

  final String standard;

  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();

  @override
  String get screenName => string.assignment + 'Page';
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  bool isTeacher = false;
  RandomColor _randomColor = RandomColor();
  ScrollController controller;
  AssignmentPageModel model;
  String stdDiv_Global;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLast = false;
  bool isLoaded = false;

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
        model.getAssignments(stdDiv_Global);
        // scaffoldKey.currentState.widget
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.standard == '') {
      var userType = Provider.of<UserType>(context, listen: false);
      AppUser currentUser = Provider.of<AppUser>(context, listen: false);
      if (userType == UserType.TEACHER) {
        if (!isLoaded) {
          stdDiv_Global =
              currentUser.standard + currentUser.division.toUpperCase() ??
                  'N.A';
          isLoaded = true;
        }
        isTeacher = true;
      } else if (userType == UserType.PARENT) {
        stdDiv_Global = 'N.A';
      } else if (userType == UserType.STUDENT) {
        if (!isLoaded) {
          stdDiv_Global =
              currentUser.standard + currentUser.division.toUpperCase();
          isLoaded = true;
        }
      }
    } else {
      stdDiv_Global = widget.standard;
      isLoaded = true;
    }

    print(stdDiv_Global);
    return BaseView<AssignmentPageModel>(
      onModelReady: (model) =>
          stdDiv_Global != 'N.A' ? model.getAssignments(stdDiv_Global) : model,
      builder: (context, model, child) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: TopBar(
              title: string.assignment,
              child: kBackBtn,
              onPressed: () {
                kbackBtn(context);
              }),
          floatingActionButton: Visibility(
            visible: isTeacher,
            child: FloatingActionButton(
              onPressed: () {
                // buildShowDialogBox(context);
                // showAboutDialog(context: context);
                showModalBottomSheet(
                  elevation: 10,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => AssignmentBottomSheet(),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
            ),
          ),
          body: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 700,
              ),
              child: RefreshIndicator(
                displacement: 10,
                child: stdDiv_Global == 'N.A'
                    ? Container(
                        child: Center(
                          child: Text(
                              '''Sorry, You Don\'t have any Class associated with you....!
If you are a parent then go to childrens section to check assignments''',
                              textAlign: TextAlign.center,
                              style: ksubtitleStyle.copyWith(
                                fontSize: 25,
                              )),
                        ),
                      )
                    : model.state == ViewState.Busy
                        ? kBuzyPage(color: Theme.of(context).primaryColor)
                        : model.assignmentSnapshotList.length == 0
                            ? Container(
                                child: Center(
                                  child: Text(
                                    'No Assignments available....!',
                                    textAlign: TextAlign.center,
                                    style:
                                        ksubtitleStyle.copyWith(fontSize: 25),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                addAutomaticKeepAlives: true,
                                cacheExtent: 10,
                                controller: controller,
                                itemCount:
                                    model.assignmentSnapshotList.length + 1,
                                itemBuilder: (context, i) {
                                  if (i < model.assignmentSnapshotList.length) {
                                    Assignment assignment =
                                        Assignment.fromSnapshot(
                                            model.assignmentSnapshotList[i]);
                                    print(assignment.id);
                                    return ColumnReusableCardButton(
                                      tileColor: _randomColor.randomColor(
                                          colorBrightness:
                                              ColorBrightness.veryDark,
                                          colorHue: ColorHue.purple,
                                          colorSaturation:
                                              ColorSaturation.highSaturation),
                                      label: assignment.title,
                                      icon: FontAwesomeIcons.bookOpen,
                                      onPressed: () {
                                        showModalBottomSheet(
                                          elevation: 10,
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) =>
                                              AssignmentDetailBottomSheet(
                                            assignment: assignment,
                                          ),
                                        );
                                      },
                                      height: 70,
                                    );
                                  } else {
                                    return Center(
                                      child: new Opacity(
                                        opacity: model.state == ViewState.Busy
                                            ? 1.0
                                            : 0.0,
                                        child: new SizedBox(
                                          width: 32.0,
                                          height: 32.0,
                                          child:
                                              new CircularProgressIndicator(),
                                        ),
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
      },
    );
  }
}
