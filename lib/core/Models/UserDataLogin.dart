import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/locator.dart';

SharedPreferencesHelper _sharedPreferencesHelper =
    locator<SharedPreferencesHelper>();

class UserDataLogin {
  String id;
  String email;
  bool isATeacher;
  List<dynamic> childIds;

  UserDataLogin({this.id, this.email, this.isATeacher = false, this.childIds}) {
    _sharedPreferencesHelper.setLoggedInUserId(id);
  }
}
