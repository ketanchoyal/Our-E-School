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
            model.getStudent(division: _division, standard: _standard),
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
      return Scaffold(
        body: Container(
          // color: Colors.red,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                ),
              ),
              Expanded(
                flex: 12,
                child: Container(
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
      );
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
