import 'package:http/http.dart' as http;
import 'package:ourESchool/imports.dart';

class ProfileServices extends Services {
  StorageServices storageServices = locator<StorageServices>();
  StreamController<User> loggedInUserStream =
      StreamController.broadcast(sync: true);

  String country = Services.country;

  ProfileServices() {
    getSchoolCode();
    getFirebaseUser();
  }

  setProfileData({
    User user,
    UserType userType,
  }) async {
    UserType userType = await sharedPreferencesHelper.getUserType();
    String photoUrl = '';
    String url = await sharedPreferencesHelper.getLoggedInUserPhotoUrl() ??
        user.photoUrl;
    if (user.photoUrl.contains('https')) {
      photoUrl = url;
    } else if (user.photoUrl == 'default') {
      photoUrl = user.photoUrl;
    } else {
      photoUrl = await storageServices.setProfilePhoto(user.photoUrl);
    }

    user.photoUrl = photoUrl;

    Map profileDataHashMap = user.toJson();

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
      // getProfileData(user.id, userType);
      print("Data Uploaded Succesfully");
      final jsonData = await json.decode(response.body);

      User user = User.fromJson(jsonData);
      sharedPreferencesHelper.setUserDataModel(response.body);
      loggedInUserStream.add(user);
    } else {
      print("Data Upload error");
    }
  }

  Future<User> getProfileData(String uid, UserType userType) async {
    // if (schoolCode == null)
    await getSchoolCode();

    String userDataModel = await sharedPreferencesHelper.getUserDataModel();

    if (userDataModel != 'N.A') {
      print("Data Retrived Succesfully (Local)");
      final jsonData = await json.decode(userDataModel);

      User user = User.fromJson(jsonData);
      sharedPreferencesHelper.setUserDataModel(userDataModel);
      loggedInUserStream.add(user);
      user.toString();
      return user;
    }

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
      sharedPreferencesHelper.setUserDataModel(response.body);
      loggedInUserStream.add(user);
      user.toString();
      return user;
    } else {
      print("Data Retrived failed");
      return User(id: uid);
    }
  }
}
