import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/services/Services.dart';

class ProfileServices extends Services {
  String country = Services.country;
  String schoolCode;
  getFirebaseUser() async {
    firebaseUser = await auth.currentUser();
  }

  getSchoolCode() async {
    schoolCode = await sharedPreferencesHelper.getSchoolCode();
  }

  ProfileServices() {
    getSchoolCode();
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
    String photoPath,
  }) async {
    String id = await sharedPreferencesHelper.getLoggedInUserId();
    // String schoolCode = await sharedPreferencesHelper.getSchoolCode();
    String photoUrl = '';
    String url =
        await sharedPreferencesHelper.getLoggedInUserPhotoUrl() ?? photoPath;
    if (photoPath == url) {
      photoUrl = url;
    } else {
      photoUrl = await setProfilePhoto(photoPath);
    }

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
    // String schoolCode = await sharedPreferencesHelper.getSchoolCode();

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

  Future<String> setProfilePhoto(String filePath) async {
    // String schoolCode = await sharedPreferencesHelper.getSchoolCode();

    String _extension = p.extension(filePath);
    String fileName = firebaseUser.uid + _extension;
    final StorageUploadTask uploadTask =
        storageReference.child(schoolCode + '/' + fileName).putFile(
              File(filePath),
              StorageMetadata(contentType: "image"),
            );

    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    final String profileUrl = await downloadUrl.ref.getDownloadURL();

    await sharedPreferencesHelper.setLoggedInUserPhotoUrl(profileUrl);

    return profileUrl;
  }
}
