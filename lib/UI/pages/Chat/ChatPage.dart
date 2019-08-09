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
      var width = MediaQuery.of(context).size.width;
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
                      child: Container(
                        color: Colors.yellow,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: model.childrens.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(2),
                            color: Colors.red,
                            child: Container(
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
