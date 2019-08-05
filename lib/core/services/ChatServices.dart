import 'package:ourESchool/imports.dart';

class ChatServices extends Services {
  ProfileServices _profileServices = locator<ProfileServices>();
  User _currentUser = User();

  List<DocumentSnapshot> studentsDocumentSnapshots = List<DocumentSnapshot>();

  List<DocumentSnapshot> teachersDocumentSnapshots = List<DocumentSnapshot>();

  ChatServices() {
    getSchoolCode();
    getFirebaseUser();
  }

  getTeachers() async {}

  _getCurrentUser(User user) {
    _currentUser = user;
  }

  getStudents({String standard = '', String division = ''}) async {
    String _standard;
    if (standard == '' && division == '') {
      String userDataModel = await sharedPreferencesHelper.getUserDataModel();
      if (userDataModel == 'N.A') {
        _profileServices.loggedInUserStream.stream.listen(_getCurrentUser);
      } else {
        _currentUser = User.fromJson(json.decode(userDataModel));
      }

      _standard = _currentUser.standardDivision();
    } else {
      _standard = standard + division.toUpperCase();
    }

    CollectionReference _studentsRef =
        (await schoolRefwithCode()).document("Students").collection(_standard);

    QuerySnapshot data = await _studentsRef.getDocuments();

    if (data != null && data.documents.length > 0) {
      studentsDocumentSnapshots.addAll(data.documents);
    }
  }

  getParents() async {}
}
