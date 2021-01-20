import 'package:ourESchool/imports.dart';

class ChatUsersListPageModel extends BaseModel {
  ChatUsersListPageModel();

  ChatServices _chatServices = locator<ChatServices>();
  // ProfileServices _profileServices = locator<ProfileServices>();

  Map<String, DocumentSnapshot> get studentsSnapshot =>
      _chatServices.studentsDocumentSnapshots;

  Map<String, DocumentSnapshot> get teachersSnapshot =>
      _chatServices.teachersDocumentSnapshots;

  Map<String, AppUser> get studentListMap => _chatServices.studentListMap;

  Map<String, AppUser> get teachersListMap => _chatServices.teachersListMap;

  Map<String, List<AppUser>> get studentsParentListMap =>
      _chatServices.studentsParentListMap;

  List<AppUser> get childrens => _chatServices.childrens;

  AppUser _selectedChild = AppUser();

  AppUser get selectedChild => _selectedChild;

  set selectedChild(AppUser newAppUser) {
    _selectedChild = newAppUser;
    notifyListeners();
  }

  getChildrens() async {
    setState(ViewState.Busy);
    await _chatServices.getChildrens();
    setState(ViewState.Idle);
  }

  getAllStudent({String standard = '', String division = ''}) async {
    setState(ViewState.Busy);
    await _chatServices.getStudents(standard: standard, division: division);
    setState(ViewState.Idle);
  }

  getSingleStudentData(DocumentSnapshot documentSnapshot) async {
    // setState(ViewState.Busy);
    AppUser user = await _chatServices.getUser(documentSnapshot);
    _chatServices.studentListMap.putIfAbsent(documentSnapshot.id, () => user);
    // await _chatServices.getParents(documentSnapshot);
    notifyListeners();
    // setState(ViewState.Idle);
  }

  getParents(DocumentSnapshot documentSnapshot) async {
    setState(ViewState.Busy);
    print('Parent Data Fetching Started');
    await _chatServices.getParents(documentSnapshot);
    setState(ViewState.Idle);
    print('Parent Data Fetched');
  }

  getAllTeachers({String standard = '', String division = ''}) async {
    setState(ViewState.Busy);
    teachersListMap.clear();
    teachersSnapshot.clear();
    await _chatServices.getTeachers(division: division, standard: standard);
    setState(ViewState.Idle);
  }

  Future<AppUser> getSingleTeacherData(
      DocumentSnapshot documentSnapshot) async {
    // setState(ViewState.Busy);
    AppUser user = await _chatServices.getUser(documentSnapshot);
    _chatServices.teachersListMap.putIfAbsent(documentSnapshot.id, () => user);
    await _chatServices.getParents(documentSnapshot);
    notifyListeners();
    return user;
    // setState(ViewState.Idle);
  }

  onRefereshStudent({String standard, String division}) async {
    _chatServices.studentsDocumentSnapshots.clear();
    await getAllStudent(standard: standard, division: division);
  }
}
