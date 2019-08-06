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

  @override
  Widget build(BuildContext context) {
    return BaseView<StudentListPageModel>(
      onModelReady: (model) =>
          model.getStudent(division: _division, standard: _standard),
      builder: (context, model, child) {
        return SafeArea(
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
  }
}
