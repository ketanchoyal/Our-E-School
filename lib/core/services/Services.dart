import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/Models/UserDataLogin.dart';
import 'package:ourESchool/core/Server.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/locator.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class Services {
  SharedPreferencesHelper _sharedPreferencesHelper =
      locator<SharedPreferencesHelper>();
  static String country =
      "India"; //Get this from firstScreen(UI Not developed yet)
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User firebaseUser;

  AppUser _user;

  UserDataLogin userDataLogin;

  String schoolCode = null;

  final Reference _storageReference =
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

  DocumentReference _schoolRef = _firestore.collection('Schools').doc(country);

  FirebaseFirestore get firestore => _firestore;
  FirebaseAuth get auth => _auth;
  AppUser get loggedInUser => _user;

  DocumentReference get schoolRef => _schoolRef;

  Future<CollectionReference> schoolRefwithCode() async =>
      _schoolRef.collection((await getSchoolCode()).toUpperCase().trim());

  Reference get storageReference => _storageReference;

  SharedPreferencesHelper get sharedPreferencesHelper =>
      _sharedPreferencesHelper;

  getFirebaseUser() async {
    firebaseUser = _auth.currentUser;
  }

  Future<String> getSchoolCode() async {
    schoolCode = await _sharedPreferencesHelper.getSchoolCode();
    return schoolCode;
  }
}
