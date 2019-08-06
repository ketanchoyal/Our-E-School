import 'package:ourESchool/imports.dart';

class ChatServices extends Services {
  ProfileServices _profileServices = locator<ProfileServices>();
  User _currentUser = User();

  Map<String, DocumentSnapshot> studentsDocumentSnapshots =
      Map<String, DocumentSnapshot>();

  Map<String, DocumentSnapshot> teachersDocumentSnapshots =
      Map<String, DocumentSnapshot>();

  Map<String, User> studentListMap = Map();

  Map<String, List<User>> studentsParentListMap = Map();

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
      if (_standard == '') {
        _standard = 'N.A';
        return;
      }
    } else {
      _standard = standard + division.toUpperCase();
    }

    CollectionReference _studentsRef =
        (await schoolRefwithCode()).document("Students").collection(_standard);

    QuerySnapshot data = await _studentsRef.getDocuments();

    if (data != null && data.documents.length > 0) {
      data.documents.forEach((document) => {
            studentsDocumentSnapshots.putIfAbsent(
                document.documentID, () => document)
          });
    }
  }

  Future<User> getUser(DocumentSnapshot documentSnapshot) async {
    User user =
        await _profileServices.getUserDataFromReference(documentSnapshot["id"]);

    studentListMap.putIfAbsent(documentSnapshot.documentID, () => user);

    return user;
  }

  Future<List<User>> getParents(DocumentSnapshot documentSnapshot) async {
    List<User> parents = [];

    for (int index = 1; index < documentSnapshot.data.length; index++) {
      await parents.add(await _profileServices.getUserDataFromReference(
          documentSnapshot[index.toString()] as DocumentReference));
    }

    studentsParentListMap.putIfAbsent(
        documentSnapshot.documentID, () => parents);

    return parents;
  }

  getMessages() async {
    var data = await firestore
        .collection('/Schools/India/AMBE001/Chats/10A/Chat/chatID')
        .getDocuments();
    print('Messages length : ' + data.documents.length.toString());
  }

  sendMessage(Message message, User student) async {
    var ref = (await schoolRefwithCode())
        .document('Chats')
        .collection(student.standardDivision())
        .document('Chat')
        .collection(getChatId([message.to, message.for_, message.from]));

    await ref.add(message.toJson());

    print('Message Sent');
  }
}
