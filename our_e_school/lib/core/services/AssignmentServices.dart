import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:ourESchool/imports.dart';

class AssignmentServices extends Services {
  StorageServices _storageServices = locator<StorageServices>();
  DocumentSnapshot lastAssignmnetSnapshot = null;
  List<DocumentSnapshot> assignmnetDocumentSnapshots = List<DocumentSnapshot>();

  AssignmentServices() {
    getFirebaseUser();
    getSchoolCode();
  }

  uploadAssignment(Assignment assignment) async {
    // await getSchoolCode();

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
    // await getSchoolCode();

    var _assignmentRef = (await schoolRefwithCode())
        .document('Assignments')
        .collection(stdDiv_Global);

    QuerySnapshot data;
    //  = await _schoolRef.getDocuments();
    try {
      if (lastAssignmnetSnapshot == null)
        data = await _assignmentRef
            .orderBy('timeStamp', descending: true)
            .limit(5)
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
    } catch (e) {
      print('In Exception : ');
    }
  }
}
