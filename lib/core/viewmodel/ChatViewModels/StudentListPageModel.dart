import 'package:ourESchool/imports.dart';

class StudentListPageModel extends BaseModel {
  StudentListPageModel();

  ChatServices _chatServices = locator<ChatServices>();
  ProfileServices _profileServices = locator<ProfileServices>();

  Map<String, DocumentSnapshot> get studentsSnapshot =>
      _chatServices.studentsDocumentSnapshots;

  Map<String, DocumentSnapshot> get teachersSnapshot =>
      _chatServices.teachersDocumentSnapshots;

  Map<String, User> get studentListMap => _chatServices.studentListMap;

  Map<String, List<User>> get studentsParentListMap =>
      _chatServices.studentsParentListMap;

  getStudent({String standard = '', String division = ''}) async {
    setState(ViewState.Busy);
    await _chatServices.getStudents(standard: standard, division: division);
    setState(ViewState.Idle);
  }

  getStudentConnectionsData(DocumentSnapshot documentSnapshot) async {
    setState(ViewState.Busy);
    await _chatServices.getUser(documentSnapshot);
    await _chatServices.getParents(documentSnapshot);
    setState(ViewState.Idle);
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
