import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/locator.dart';

SharedPreferencesHelper _sharedPreferencesHelper =
    locator<SharedPreferencesHelper>();

class UserDataLogin {
  String id;
  String email;
  bool isATeacher;
  List<dynamic> childIds;
  List<dynamic> parentIds;

  UserDataLogin(
      {this.id,
      this.email,
      this.isATeacher = false,
      this.childIds,
      this.parentIds}) {
    _sharedPreferencesHelper.setLoggedInUserId(id);
    if (childIds.isNotEmpty) {
      _sharedPreferencesHelper.setChildIds(childIds);
    }
    if (parentIds.isNotEmpty) {
      _sharedPreferencesHelper.setParentsIds(parentIds);
    }
    
  }
}
