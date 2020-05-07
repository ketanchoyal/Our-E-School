import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/Models/UserDataLogin.dart';
import 'package:ourESchool/core/Server.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/locator.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Services {
  SharedPreferencesHelper _sharedPreferencesHelper =
      locator<SharedPreferencesHelper>();
  static String country =
      "India"; //Get this from firstScreen(UI Not developed yet)
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Firestore _firestore = Firestore.instance;

  FirebaseUser firebaseUser;

  User _user;

  UserDataLogin userDataLogin;

  String schoolCode = null;

  final StorageReference _storageReference =
      FirebaseStorage.instance.ref().child(country);

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  String baseUrl = Server.baseUrl;

  String webApiUrl = Server.baseUrl + Server.webApi;

  String profileUpdateUrl =
      Server.baseUrl + Server.webApi + Server.profileUpdate;

  String getProfileDataUrl =
      Server.baseUrl + Server.webApi + Server.getProfileData;

  String postAnnouncemnetUrl =
      Server.baseUrl + Server.webApi + Server.postAnnouncement;

  String addAssignmentUrl =
      Server.baseUrl + Server.webApi + Server.addAssignment;

  DocumentReference _schoolRef =
      _firestore.collection('Schools').document(country);

  Firestore get firestore => _firestore;
  FirebaseAuth get auth => _auth;
  User get loggedInUser => _user;

  DocumentReference get schoolRef => _schoolRef;

  Future<CollectionReference> schoolRefwithCode() async =>
      _schoolRef.collection((await getSchoolCode())
          .toUpperCase()
          .trim());

  StorageReference get storageReference => _storageReference;

  SharedPreferencesHelper get sharedPreferencesHelper =>
      _sharedPreferencesHelper;

  getFirebaseUser() async {
    firebaseUser = await _auth.currentUser();
  }

  Future<String> getSchoolCode() async {
    schoolCode = await _sharedPreferencesHelper.getSchoolCode();
    return schoolCode;
  }
}
