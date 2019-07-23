import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/core/Models/Assignment.dart';
import 'package:ourESchool/core/services/Services.dart';
import 'package:ourESchool/locator.dart';
import 'StorageServices.dart';
import 'package:path/path.dart' as p;

class AssignmentServices extends Services {
  StorageServices _storageServices = locator<StorageServices>();
  DocumentSnapshot lastAssignmnetSnapshot = null;
  List<DocumentSnapshot> assignmnetDocumentSnapshots =
      new List<DocumentSnapshot>();

  AssignmentServices() {
    getFirebaseUser();
    getSchoolCode();
  }

  uploadAssignment(Assignment assignment) async {
    await getSchoolCode();

    String extension = p.extension(assignment.url);

    if (extension == '.pdf') {
      assignment.type = 'PDF';
    } else {
      assignment.type = 'Image';
    }

    String fileName =
        createCryptoRandomString(8) + createCryptoRandomString(8) + extension;

    assignment.url =
        await _storageServices.uploadAssignment(assignment.url, fileName);

    String filePath = '${Services.country}/$schoolCode/Assignments/$fileName';
    assignment.path = filePath;

    Map assignmentMap = assignment.toJson();

    var body = json.encode({
      "schoolCode": schoolCode.toUpperCase(),
      "country": Services.country,
      "assignment": assignmentMap
    });

    print('Upload Assignmnet body : ' + body.toString());

    final response =
        await http.post(addAssignmentUrl, body: body, headers: headers);

    if (response.statusCode == 200) {
      print("Assignment added Succesfully");
      print(json.decode(response.body).toString());
    } else {
      print("Assignment adding failed");
    }
  }

  getAssignments(String stdDiv_Global) async {
    await getSchoolCode();

    var _assignmentRef = schoolRef
        .collection(schoolCode)
        .document('Assignments')
        .collection(stdDiv_Global);

    QuerySnapshot data;
    //  = await _schoolRef.getDocuments();
    if (lastAssignmnetSnapshot == null)
      data = await _assignmentRef
          .orderBy('timeStamp', descending: true)
          .limit(10)
          .getDocuments();
    else
      data = await _assignmentRef
          .orderBy('timeStamp', descending: true)
          .startAfter([lastAssignmnetSnapshot['timeStamp']])
          .limit(5)
          .getDocuments();

    if (data != null && data.documents.length > 0) {
      lastAssignmnetSnapshot = data.documents[data.documents.length - 1];
      assignmnetDocumentSnapshots.addAll(data.documents);
    }
  }
}
