import 'package:ourESchool/imports.dart';

class ChatServices extends Services {
  ProfileServices _profileServices = locator<ProfileServices>();
  AppUser _currentUser = AppUser();

  Map<String, DocumentSnapshot> studentsDocumentSnapshots =
      Map<String, DocumentSnapshot>();

  Map<String, DocumentSnapshot> teachersDocumentSnapshots =
      Map<String, DocumentSnapshot>();

  Map<String, AppUser> studentListMap = Map();

  Map<String, AppUser> teachersListMap = Map();

  Map<String, List<AppUser>> studentsParentListMap = Map();

  List<AppUser> get childrens => _profileServices.childrens;

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
    var ref = (await schoolRefwithCode()).doc('Teachers').collection(_standard);

    QuerySnapshot data = await ref.get();

    if (data != null && data.docs.length > 0) {
      print('Data Added');
      print(data.docs.first.id);
      data.docs.forEach((document) =>
          {teachersDocumentSnapshots.putIfAbsent(document.id, () => document)});
    }
  }

  _getCurrentUser(AppUser user) {
    _currentUser = user;
  }

  getStudents({String standard = '', String division = ''}) async {
    String _standard;
    if (standard == '' && division == '') {
      String userDataModel = await sharedPreferencesHelper.getUserDataModel();
      if (userDataModel == 'N.A') {
        _profileServices.loggedInUserStream.stream.listen(_getCurrentUser);
      } else {
        _currentUser = AppUser.fromJson(json.decode(userDataModel));
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
        (await schoolRefwithCode()).doc("Students").collection(_standard);

    QuerySnapshot data = await _studentsRef.get();

    if (data != null && data.docs.length > 0) {
      data.docs.forEach((document) =>
          {studentsDocumentSnapshots.putIfAbsent(document.id, () => document)});
    }
  }

  Future<AppUser> getUser(DocumentSnapshot documentSnapshot) async {
    AppUser user =
        await _profileServices.getUserDataFromReference(documentSnapshot["id"]);

    // studentListMap.putIfAbsent(documentSnapshot.documentID, () => user);

    return user;
  }

  Future<List<AppUser>> getParents(DocumentSnapshot documentSnapshot) async {
    List<AppUser> parents = [];

    for (int index = 1; index < documentSnapshot.data().length; index++) {
      await parents.add(await _profileServices.getUserDataFromReference(
          documentSnapshot[index.toString()] as DocumentReference));
    }

    studentsParentListMap.putIfAbsent(documentSnapshot.id, () => parents);

    return parents;
  }

  Stream<List<Message>> getMessages({
    @required AppUser other,
    @required AppUser student,
    @required AppUser loggedIn,
    ScrollController scrollController,
  }) async* {
    var ref = (await schoolRefwithCode())
        .doc('Chats')
        .collection(student.standardDivision())
        .doc('Parent-Teacher')
        .collection(loggedIn.id)
        .doc(other.id);

    String chatRef = 'N.A';

    await ref
        .get(GetOptions(source: Source.server))
        .then((snapShot) => {chatRef = snapShot[student.id].toString()});

    await for (QuerySnapshot snap in firestore
        .collection(chatRef)
        .orderBy('timestamp', descending: true)
        .snapshots()) {
      try {
        List<Message> messages =
            snap.docs.map((doc) => Message.fromSnapShot(doc)).toList();
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

  Future sendMessage(Message message, AppUser student) async {
    var ref = (await schoolRefwithCode())
        .doc('Chats')
        .collection(student.standardDivision())
        .doc('Chat')
        .collection(getChatId([message.to, message.for_, message.from]));

    await ref.add(message.toJson());

    print('Message Sent');
  }
}
