import 'package:ourESchool/imports.dart';

class StudentListPageModel extends BaseModel {
  StudentListPageModel();

  ChatServices _chatServices = locator<ChatServices>();
  ProfileServices _profileServices = locator<ProfileServices>();

  List<DocumentSnapshot> get studentsSnapshot =>
      _chatServices.studentsDocumentSnapshots;

  List<DocumentSnapshot> get teachersSnapshot =>
      _chatServices.teachersDocumentSnapshots;

  getStudent({String standard = '', String division = ''}) async {
    setState(ViewState.Busy);

    await _chatServices.getStudents(standard: standard, division: division);

    setState(ViewState.Idle);
  }

  Future<User> getUser(DocumentSnapshot documentSnapshot) async {
    User user =
        await _profileServices.getUserDataFromReference(documentSnapshot["id"]);

    return user;
  }

  Future<List<User>> getParents(DocumentSnapshot documentSnapshot) async {
    List<User> parents;
    setState(ViewState.Busy);
    for (int index = 1; index < documentSnapshot.data.length; index++) {
      await parents.add(await _profileServices.getUserDataFromReference(
          documentSnapshot[index.toString()] as DocumentReference));
    }
    setState(ViewState.Idle);
    return parents;
  }

  getTeachers() {
    setState(ViewState.Busy);

    setState(ViewState.Idle);
  }

  onRefereshStudent({String standard, String division}) async {
    _chatServices.studentsDocumentSnapshots.clear();
    await getStudent(standard: standard, division: division);
  }
}
