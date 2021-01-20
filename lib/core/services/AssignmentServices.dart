import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:ourESchool/imports.dart';

class AssignmentServices extends Services {
  StorageServices _storageServices = locator<StorageServices>();
  DocumentSnapshot lastAssignmnetSnapshot = null;
  List<DocumentSnapshot> assignmnetDocumentSnapshots =
      List.empty(growable: true);

  AssignmentServices() {
    getFirebaseUser();
    getSchoolCode();
  }

  uploadAssignment(Assignment assignment) async {
    // await getSchoolCode();

    String ext = p.extension(assignment.url);

    if (ext == '.pdf') {
      assignment.type = 'PDF';
    } else {
      assignment.type = 'Image';
    }

    String fileName =
        createCryptoRandomString(8) + createCryptoRandomString(8) + ext;

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
        .doc('Assignments')
        .collection(stdDiv_Global);

    QuerySnapshot data;
    //  = await _schoolRef.getDocuments();
    try {
      if (lastAssignmnetSnapshot == null)
        data = await _assignmentRef
            .orderBy('timeStamp', descending: true)
            .limit(5)
            .get();
      else
        data = await _assignmentRef
            .orderBy('timeStamp', descending: true)
            .startAfter([lastAssignmnetSnapshot['timeStamp']])
            .limit(5)
            .get();

      if (data != null && data.docs.length > 0) {
        lastAssignmnetSnapshot = data.docs[data.docs.length - 1];
        assignmnetDocumentSnapshots.addAll(data.docs);
      }
    } catch (e) {
      print('In Exception : ');
    }
  }
}
