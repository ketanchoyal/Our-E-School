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

  AssignmentPageModel() {}

  getAssignments(String stdDiv_Global) async {
    setState(ViewState.Busy);
    _assignmentServices.getAssignments(stdDiv_Global);
    setState(ViewState.Idle);
  }

  addAssignment(Assignment assignment) async {
    setState(ViewState.Busy);
    _assignmentServices.uploadAssignment(assignment);
    setState(ViewState.Idle);
  }
}
