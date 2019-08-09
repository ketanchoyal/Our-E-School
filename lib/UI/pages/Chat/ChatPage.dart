import 'package:ourESchool/imports.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);
  static String pageName = string.chat;

  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  RandomColor _randomColor = RandomColor();

  String _standard = '';
  String _division = '';
  bool studentLoaded = false;

  @override
  Widget build(BuildContext context) {
    UserType userType = Provider.of<UserType>(context);
    if (userType == UserType.TEACHER) {
      return BaseView<ChatUsersListPageModel>(
        onModelReady: (model) =>
            model.getAllStudent(division: _division, standard: _standard),
        builder: (context, model, child) {
          return model.state == ViewState.Busy
              ? kBuzyPage(color: Theme.of(context).primaryColor)
              : SafeArea(
                  child: Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: model.studentsSnapshot.length,
                        itemBuilder: (context, i) {
                          // values.keys.elementAt(index);
                          var key = model.studentsSnapshot.keys.elementAt(i);
                          var snapshot = model.studentsSnapshot[key];
                          // model.getUser(snapshot);
                          // model.getParents(snapshot);
                          // return Container(
                          //   color: _randomColor.randomColor(),
                          //   height: 50,
                          //   width: MediaQuery.of(context).size.width / 2,
                          // );
                          return ChatStudentListWidget(
                            heroTag: snapshot.documentID,
                            snapshot: snapshot,
                            model: model,
                          );
                        },
                      ),
                    ),
                  ),
                );
        },
      );
    } else if (userType == UserType.PARENT) {
      // User children = User();
      return BaseView<ChatUsersListPageModel>(
          onModelReady: (model) => model.getChildrens(),
          builder: (context, model, child) {
            return Scaffold(
              body: Container(
                // color: Colors.red,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 12,
                      child: model.selectedChild.isEmpty()
                          ? Container(
                              color: Colors.red,
                            )
                          : model.state == ViewState.Busy
                              ? kBuzyPage(color: Theme.of(context).primaryColor)
                              : Container(
                                  color: Colors.yellow,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListView.builder(
                                      itemCount: model.teachersSnapshot.length,
                                      itemBuilder: (context, i) {
                                        // values.keys.elementAt(index);
                                        var key = model.teachersListMap.keys
                                            .elementAt(i);
                                        var snapshot =
                                            model.teachersSnapshot[key];
                                        return ChatTeachersListWidget(
                                          heroTag: snapshot.documentID,
                                          snapshot: snapshot,
                                          model: model,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: model.childrens.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              model.selectedChild = model.childrens[index];
                              model.getAllTeachers(
                                  division: model.selectedChild.division,
                                  standard: model.selectedChild.standard);
                            },
                            // enableFeedback: true,
                            highlightColor: Colors.deepPurple,
                            child: Card(
                              elevation: 0,
                              margin: EdgeInsets.all(2),
                              color: Colors.red,
                              child: Container(
                                decoration: new BoxDecoration(
                                  gradient: new LinearGradient(
                                    colors: [
                                      Theme.of(context).accentColor,
                                      Theme.of(context).canvasColor,
                                    ],
                                    begin: const FractionalOffset(0.0, 0.5),
                                    end: const FractionalOffset(0.5, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp,
                                  ),
                                ),
                                width:
                                    (MediaQuery.of(context).size.width / 2) - 4,
                                child: Row(
                                  // mainAxisSize: ,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.child,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      model.childrens[index].displayName,
                                      style: ktitleStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      return Scaffold(
        body: Center(
          child: Text(
            'No UserType Found',
            style: ktitleStyle,
          ),
        ),
      );
    }
  }
}
