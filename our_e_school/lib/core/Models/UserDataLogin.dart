import 'package:ourESchool/imports.dart';

SharedPreferencesHelper _sharedPreferencesHelper =
    locator<SharedPreferencesHelper>();

class UserDataLogin {
  String id;
  String email;
  bool isATeacher;
  Map childIds = Map<dynamic, dynamic>();
  Map parentIds = Map<dynamic, dynamic>();

  UserDataLogin(
      {this.id,
      this.email,
      this.isATeacher = false,
      this.childIds,
      this.parentIds}) {
    setData();
  }

  setData() async {
    print('In UserDataLogin Object');
    await _sharedPreferencesHelper.setLoggedInUserId(id);
    if (childIds != null) {
      String childsId = json.encode(childIds);
      _sharedPreferencesHelper.setChildIds(childsId);
    }

    if (parentIds != null) {
      String parentsId = json.encode(parentIds);
      _sharedPreferencesHelper.setParentsIds(parentsId);
    }
  }
}
