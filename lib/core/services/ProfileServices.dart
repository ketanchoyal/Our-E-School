// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ourESchool/imports.dart';

class ProfileServices extends Services {
  StorageServices storageServices = locator<StorageServices>();
  StreamController<AppUser> loggedInUserStream =
      StreamController.broadcast(sync: true);

  String country = Services.country;

  List<AppUser> childrens = [];

  ProfileServices() {
    getSchoolCode();
    getFirebaseUser();
  }

  setProfileData({
    AppUser user,
    UserType userType,
  }) async {
    UserType userType = await sharedPreferencesHelper.getUserType();
    // String photoUrl = '';
    // String url = await sharedPreferencesHelper.getLoggedInUserPhotoUrl();

    if (user.photoUrl.contains('https')) {
      // photoUrl = url;
    } else if (user.photoUrl == 'default') {
      // user.photoUrl = user.photoUrl;
    } else {
      user.photoUrl = await storageServices.setProfilePhoto(user.photoUrl);
    }

    // user.photoUrl = photoUrl;

    Map profileDataHashMap = user.toJson();

    var body = json.encode({
      "schoolCode": schoolCode.trim().toUpperCase(),
      "profileData": profileDataHashMap,
      "userType": UserTypeHelper.getValue(userType),
      "country": country
    });

    Dio dio = Dio();
    Options options = Options(
      contentType: 'multipart/form-data',
      headers: headers,
    );

    final response = await dio.post(
      profileUpdateUrl,
      options: options,
      data: body,
      // body: body,
      // headers: headers,
    );

    if (response.statusCode == 200) {
      // getProfileData(user.id, userType);
      print("Data Uploaded Succesfully");
      final jsonData = await json.decode(response.data.toString());

      AppUser user = AppUser.fromJson(jsonData);
      sharedPreferencesHelper.setUserDataModel(response.data.toString());
      loggedInUserStream.add(user);
    } else {
      print("Data Upload error");
    }
  }

  Future<AppUser> getLoggedInUserProfileData() async {
    // if (schoolCode == null)
    await getSchoolCode();
    String id = await sharedPreferencesHelper.getLoggedInUserId();
    UserType userType = await sharedPreferencesHelper.getUserType();

    String userDataModel = await sharedPreferencesHelper.getUserDataModel();

    if (userDataModel != 'N.A') {
      print("Data Retrived Succesfully (Local)");
      final jsonData = await json.decode(userDataModel);

      AppUser user = AppUser.fromJson(jsonData);
      loggedInUserStream.add(user);
      user.toString();
      return user;
    }

    var body = json.encode({
      "schoolCode": schoolCode.trim().toUpperCase(),
      "id": id,
      "userType": UserTypeHelper.getValue(userType),
      "country": country
    });

    print(body);

    Dio dio = Dio();
    Options options = Options(
      contentType: 'multipart/form-data',
      headers: headers,
    );

    final response = await dio.post(
      getProfileDataUrl,
      options: options,
      data: body,
      // body: body,
      // headers: headers,
    );
    if (response.statusCode == 200) {
      print("Data Retrived Succesfully");
      final jsonData = await json.decode(response.data.toString());

      AppUser user = AppUser.fromJson(jsonData);
      sharedPreferencesHelper.setUserDataModel(response.data.toString());
      loggedInUserStream.add(user);
      user.toString();
      return user;
    } else {
      print("Data Retrived failed");
      return AppUser(id: id);
    }
  }

  //Fetch Profile Data Using Firestore SDK
  Future<AppUser> getProfileDataById(String uid, UserType userType) async {
    DocumentReference profielRef = await _getProfileRef(uid, userType);

    try {
      AppUser user = AppUser.fromSnapshot(
          await profielRef.get(GetOptions(source: Source.serverAndCache)));
      return user;
    } catch (e) {
      print(e);
      return AppUser(id: uid);
    }
  }

  Future<AppUser> getUserDataFromReference(DocumentReference reference) async {
    AppUser user = AppUser.fromSnapshot(await reference.get());
    return user;
  }

  getChildrens() async {
    String childrens = await sharedPreferencesHelper.getChildIds();
    if (childrens == 'N.A') {
      this.childrens = [];
      return;
    }
    Map<String, String> childIds = Map.from(
      jsonDecode(childrens).map(
        (key, values) {
          String value = values.toString();
          return MapEntry(key, value);
        },
      ),
    );
    await _getChildrensData(childIds);
  }

  _getChildrensData(Map<String, String> childIds) async {
    List<AppUser> childData = [];
    for (String id in childIds.values) {
      childData.add(await getProfileDataById(id, UserType.STUDENT));
    }
    childrens = childData;
  }

  Future<DocumentReference> _getProfileRef(
      String uid, UserType userType) async {
    await getSchoolCode();
    DocumentReference ref = (await schoolRefwithCode()).doc('Profile');
    switch (userType) {
      case UserType.STUDENT:
        return ref.collection('Student').doc(uid);
        break;
      case UserType.TEACHER:
      case UserType.PARENT:
        return ref.collection('Parent-Teacher').doc(uid);
        break;
      case UserType.UNKNOWN:
        return null;
        break;
      default:
        return null;
    }
  }

  //Fetch Profile Data Using HTTP Request
  Future<AppUser> getProfileDataByIdd(String uid, UserType userType) async {
    await getSchoolCode();
    var body = json.encode({
      "schoolCode": schoolCode.trim().toUpperCase(),
      "id": uid,
      "userType": UserTypeHelper.getValue(userType),
      "country": country
    });

    print(body);

    Dio dio = Dio();
    Options options = Options(
      contentType: 'multipart/form-data',
      headers: headers,
    );

    final response = await dio.post(
      profileUpdateUrl,
      options: options,
      data: body,
      // body: body,
      // headers: headers,
    );

    // final response = await http.post(
    //   getProfileDataUrl,
    //   body: body,
    //   headers: headers,
    // );
    if (response.statusCode == 200) {
      print("Data Retrived Succesfully");
      final jsonData = await json.decode(response.data.toString());

      AppUser user = AppUser.fromJson(jsonData);
      user.toString();
      return user;
    } else {
      print("Data Retrived failed");
      return AppUser(id: uid);
    }
  }
}
