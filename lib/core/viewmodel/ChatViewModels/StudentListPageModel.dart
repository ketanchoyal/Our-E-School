import 'package:ourESchool/imports.dart';

class StudentListPageModel extends BaseModel {

  StudentListPageModel();

  ChatServices _chatServices = locator<ChatServices>();

  List<DocumentSnapshot> get studentsSnapshot =>
      _chatServices.studentsDocumentSnapshots;

  List<DocumentSnapshot> get teachersSnapshot =>
      _chatServices.teachersDocumentSnapshots;

  getStudent({String standard = '', String division = ''}) async {
    setState(ViewState.Busy);

    await _chatServices.getStudents(standard: standard, division: division);

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
