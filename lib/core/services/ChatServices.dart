import 'package:ourESchool/imports.dart';

class ChatServices extends Services {
  ProfileServices _profileServices = locator<ProfileServices>();
  User _currentUser = User();

  Map<String, DocumentSnapshot> studentsDocumentSnapshots =
      Map<String, DocumentSnapshot>();

  Map<String, DocumentSnapshot> teachersDocumentSnapshots =
      Map<String, DocumentSnapshot>();

  Map<String, User> studentListMap = Map();

  Map<String, User> teachersListMap = Map();

  Map<String, List<User>> studentsParentListMap = Map();

  List<User> get childrens => _profileServices.childrens;

  ChatServices() {
    getSchoolCode();
    getFirebaseUser();
  }

  getChildrens() async {
    await _profileServices.getChildrens();
  }

  getTeachers({String standard = '', String division = ''}) async {
    teachersDocumentSnapshots.clear();
    teachersListMap.clear();
    String _standard = standard + division.toUpperCase();
    var ref =
        (await schoolRefwithCode()).document('Teachers').collection(_standard);

    QuerySnapshot data = await ref.getDocuments();

    if (data != null && data.documents.length > 0) {
      print('Data Added');
      print(data.documents.first.documentID);
      data.documents.forEach((document) => {
            teachersDocumentSnapshots.putIfAbsent(
                document.documentID, () => document)
          });
    }
  }

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

    // studentListMap.putIfAbsent(documentSnapshot.documentID, () => user);

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

  Stream<List<Message>> getMessages({
    @required User other,
    @required User student,
    @required User loggedIn,
    ScrollController scrollController,
  }) async* {
    
    var ref = (await schoolRefwithCode())
        .document('Chats')
        .collection(student.standardDivision())
        .document('Parent-Teacher')
        .collection(loggedIn.id)
        .document(other.id);

    String chatRef = 'N.A';

    await ref
        .get(source: Source.server)
        .then((snapShot) => {chatRef = snapShot[student.id].toString()});

    await for (QuerySnapshot snap in firestore
        .collection(chatRef)
        .orderBy('timestamp', descending: true)
        .snapshots()) {
      try {
        List<Message> messages =
            snap.documents.map((doc) => Message.fromSnapShot(doc)).toList();
        yield messages;
        Future.delayed(Duration(milliseconds: 200));
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeOut,
        );
      } catch (e) {
        print(e);
      }
    }
  }

  Future sendMessage(Message message, User student) async {
    var ref = (await schoolRefwithCode())
        .document('Chats')
        .collection(student.standardDivision())
        .document('Chat')
        .collection(getChatId([message.to, message.for_, message.from]));

    await ref.add(message.toJson());

    print('Message Sent');
  }
}
