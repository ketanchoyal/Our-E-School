import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/core/services/ProfileServices.dart';
import 'package:ourESchool/core/viewmodel/BaseModel.dart';
import 'package:ourESchool/locator.dart';

class ProfilePageModel extends BaseModel {
  final _profileServices = locator<ProfileServices>();
  final _sharedPreferences = locator<SharedPreferencesHelper>();
  User userProfile;

  Future<bool> setUserProfileData({
    User user,
    UserType userType,
    
  }) async {
    setState(ViewState.Busy);

    await _profileServices.setProfileData(
        user :user,
        userType: userType);
    await Future.delayed(const Duration(seconds: 3), () {});

    setState(ViewState.Idle);
    return true;
  }

  Future<User> getUserProfileData() async {
    setState(ViewState.Busy);
    setState2(ViewState.Busy);
    String id = await _sharedPreferences.getLoggedInUserId();
    UserType userType = await _sharedPreferences.getUserType();
    userProfile = await _profileServices.getProfileData(id, userType);
    setState2(ViewState.Idle);
    setState(ViewState.Idle);
    return userProfile;
  }

  // Future<User> getUserProfileDatabyId(UserType userType, String id) async {
  //   setState(ViewState.Busy);
  //   setState2(ViewState.Busy);
  //   // String id = await _sharedPreferences.getLoggedInUserId();
  //   // UserType userType = await _sharedPreferences.getUserType();
  //   userProfile = await _profileServices.getProfileData(id, userType);
  //   setState2(ViewState.Idle);
  //   setState(ViewState.Idle);
  //   return userProfile;
  // }

  // Future<User> getUserProfileDataOfGuardian(UserType userType, String id) async {
  //   setState(ViewState.Busy);
  //   setState2(ViewState.Busy);
  //   // String id = await _sharedPreferences.getLoggedInUserId();
  //   // UserType userType = await _sharedPreferences.getUserType();
  //   userProfile = await _profileServices.getProfileData(id, userType);
  //   setState2(ViewState.Idle);
  //   setState(ViewState.Idle);
  //   return userProfile;
  // }
}
