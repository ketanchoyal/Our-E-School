import 'dart:async';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/services/ProfileServices.dart';
import 'package:ourESchool/core/viewmodel/BaseModel.dart';
import 'package:ourESchool/locator.dart';

class ProfilePageModel extends BaseModel {
  final _profileServices = locator<ProfileServices>();

  User userProfile;

  List<User> get childrens => _profileServices.childrens;

  ProfilePageModel() {
    getUserProfileData();
    getChildrens();
  }

  ProfilePageModel.getChildrens() {
    getChildrens();
  }

  Future<bool> setUserProfileData({
    User user,
    UserType userType,
  }) async {
    setState(ViewState.Busy);

    await _profileServices.setProfileData(user: user, userType: userType);
    await Future.delayed(const Duration(seconds: 3), () {});

    setState(ViewState.Idle);
    return true;
  }

  Future<User> getUserProfileData() async {
    setState(ViewState.Busy);
    setState2(ViewState.Busy);
    userProfile = await _profileServices.getLoggedInUserProfileData();
    // loggedInUserStream.add(userProfile);
    setState2(ViewState.Idle);
    setState(ViewState.Idle);
    return userProfile;
  }

  getChildrens() async {
    setState(ViewState.Busy);
    await _profileServices.getChildrens();
    setState(ViewState.Idle);
  }

  // _getChildrensData(Map<String, String> childIds) async {
  //   List<User> childData = [];
  //   for (String id in childIds.values) {
  //     childData.add(await getUserProfileDatabyId(UserType.STUDENT, id));
  //   }
  // childrens = childData;
  //   return childData;
  // }

  Future<User> getUserProfileDataById(UserType userType, String id) async {
    setState(ViewState.Busy);
    userProfile = await _profileServices.getProfileDataById(id, userType);
    setState(ViewState.Idle);
    return userProfile;
  }

  Future<User> getUserProfileDataByIdForAnnouncement(
      UserType userType, String id) async {
    userProfile = await _profileServices.getProfileDataById(id, userType);
    return userProfile;
  }

  @override
  void dispose() {
    if (true) {
    } 
  }

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
