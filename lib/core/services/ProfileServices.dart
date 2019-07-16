import 'dart:collection';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/services/Services.dart';

class ProfileServices extends Services {
  getFirebaseUser() async {
    firebaseUser = await auth.currentUser();
  }

  ProfileServices() {
    getFirebaseUser();
  }

  setProfileData({
    String enrollNo,
    String displayName,
    String standard,
    String division,
    String bloodGroup,
    String mobileNo,
    String dob,
    String guardianName,
    UserType userType,
    var photoUrl,
  }) async {
    String id = await sharedPreferencesHelper.getLoggedInUserId();
    DocumentReference ref = await getProfileRef(id, userType);

    User profileData = User(
        bloodGroup: bloodGroup,
        displayName: displayName,
        division: division,
        dob: dob,
        email: firebaseUser.email,
        enrollNo: enrollNo,
        firebaseUuid: firebaseUser.uid,
        guardianName: guardianName,
        id: id,
        isTeacher: false,
        isVerified: firebaseUser.isEmailVerified,
        mobileNo: mobileNo,
        photoUrl: photoUrl,
        standard: standard);

    Map profileDataHashMap = profileData.toJson();

    await ref.updateData(profileDataHashMap);

    print("Data Uploaded Succesfully");
  }

  Future<User> getProfileData(String uid, UserType userType) async {
    DocumentReference ref = await getProfileRef(uid, userType);

    User user = User.fromSnapshot(await ref.get()) ?? User();
    user.toString();

    return user;
  }
}
