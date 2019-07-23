import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/core/Models/Assignment.dart';
import 'package:ourESchool/core/services/Services.dart';
import 'package:ourESchool/locator.dart';
import 'StorageServices.dart';
import 'package:path/path.dart' as p;

class AssignmentServices extends Services {
  StorageServices _storageServices = locator<StorageServices>();

  AssignmentServices() {
    getFirebaseUser();
    getSchoolCode();
  }

  uploadAssignment(Assignment assignment) async {
    await getSchoolCode();

    String fileName = createCryptoRandomString(8) +
        createCryptoRandomString(8) +
        p.extension(assignment.url);

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
}
