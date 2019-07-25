import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ourESchool/core/Models/Assignment.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/services/AssignmentServices.dart';
import 'package:ourESchool/core/viewmodel/BaseModel.dart';
import 'package:ourESchool/locator.dart';

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
    // TODO: implement dispose
    super.dispose();
    print('Assignment Page Model Disposed');
  }
}
