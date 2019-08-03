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

  getChildrens() async {}

  _getCurrentUser(User user) {
    _currentUser = user;
  }

  getStudents() async {
    await _profileServices.loggedInUserStream.stream.listen(_getCurrentUser);

    var standard = _currentUser.standardDivision();

    QuerySnapshot data = await (await schoolRefwithCode())
        .document('Students')
        .collection(standard)
        .getDocuments(source: Source.serverAndCache);

    if (data != null && data.documents.length > 0) {
      studentsDocumentSnapshots.addAll(data.documents);
    }
  }

  getParents() async {}
}
