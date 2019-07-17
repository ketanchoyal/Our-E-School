import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/locator.dart';

SharedPreferencesHelper _sharedPreferencesHelper =
    locator<SharedPreferencesHelper>();

class UserDataLogin {
  String id;
  String email;
  bool isATeacher;
  List<dynamic> childIds = null;
  List<dynamic> parentIds = null;

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
      List<String> childsId = [];
      childIds.forEach((val) => childsId.add(val.toString()));
      _sharedPreferencesHelper.setChildIds(childsId);
    }

    if (parentIds != null) {
      List<String> parentsId = [];
      parentIds.forEach((val) => parentsId.add(val));
      _sharedPreferencesHelper.setParentsIds(parentsId);
    }
  }
}
