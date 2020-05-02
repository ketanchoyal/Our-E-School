import 'package:ourESchool/imports.dart';

class AssignmentPageModel extends BaseModel {
  AssignmentServices _assignmentServices = locator<AssignmentServices>();

  List<DocumentSnapshot> get assignmentSnapshotList =>
      _assignmentServices.assignmnetDocumentSnapshots;

  AssignmentPageModel() {
    print('Assignment Page Model Created');
  }

  getAssignments(String stdDiv_Global) async {
    setState(ViewState.Busy);
    await _assignmentServices.getAssignments(stdDiv_Global);
    setState(ViewState.Idle);
  }

  addAssignment(Assignment assignment) async {
    setState(ViewState.Busy);
    await _assignmentServices.uploadAssignment(assignment);
    await Future.delayed(const Duration(seconds: 3), () {});
    setState(ViewState.Idle);
  }

  onRefresh(String stdDiv_Global) async {
    await getAssignments(stdDiv_Global);
  }

  @override
  void dispose() {
    assignmentSnapshotList.clear();
    _assignmentServices.lastAssignmnetSnapshot = null;
    super.dispose();
    print('Assignment Page Model Disposed');
  }
}
