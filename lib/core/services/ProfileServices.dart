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
    String schoolCode = await sharedPreferencesHelper.getSchoolCode();

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

    var body = json.encode({
      "schoolCode": schoolCode.trim().toUpperCase(),
      "profileData": profileDataHashMap,
      "userType": UserTypeHelper.getValue(userType),
      "country": country
    });

    final response = await http.post(
      profileUpdateUrl,
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      print("Data Uploaded Succesfully");
    } else {
      print("Data Upload error");
    }
  }

  Future<User> getProfileData(String uid, UserType userType) async {
    String schoolCode = await sharedPreferencesHelper.getSchoolCode();

    var body = json.encode({
      "schoolCode": schoolCode.trim().toUpperCase(),
      "id": uid,
      "userType": UserTypeHelper.getValue(userType),
      "country": country
    });

    print(body);

    final response = await http.post(
      getProfileDataUrl,
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      print("Data Retrived Succesfully");
      final jsonData = await json.decode(response.body);

      User user = User.fromJson(jsonData);
      user.toString();
      return user;
    } else {
      print("Data Retrived failed");
      return User();
    }
  }
}
