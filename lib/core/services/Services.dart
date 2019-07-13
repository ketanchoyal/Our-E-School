import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/Models/UserDataLogin.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/locator.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Services {
  SharedPreferencesHelper _sharedPreferencesHelper =
      locator<SharedPreferencesHelper>();
  String country = "India"; //Get this from firstScreen(UI Not developed yet)
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static Firestore _firestore = Firestore.instance;
  FirebaseUser firebaseUser;
  User _user;
  UserDataLogin userDataLogin;
  final StorageReference _storageReference = FirebaseStorage.instance.ref();

  static String baseUrl = 'https://us-central1-our-e-school.cloudfunctions.net/';
  static String webApiUrl = baseUrl + 'webApi/';
  String functionName = webApiUrl + 'profileupdate';

  DocumentReference _schoolRef =
      _firestore.collection('Schools').document('India');

  Firestore get firestore => _firestore;
  FirebaseAuth get auth => _auth;
  // FirebaseUser get firebaseUser => _firebaseUser;
  User get loggedInUser => _user;
  DocumentReference get schoolRef => _schoolRef;
  StorageReference get storageReference => _storageReference;
  SharedPreferencesHelper get sharedPreferencesHelper =>
      _sharedPreferencesHelper;

  Future<DocumentReference> getProfileRef(String id, UserType userType) async {
    String schoolCode = await _sharedPreferencesHelper.getSchoolCode();
    DocumentReference ref = _schoolRef
        .collection(schoolCode.toUpperCase().trim())
        .document('Profile');
    switch (userType) {
      case UserType.STUDENT:
        return ref.collection('Student').document(id);
        break;
      case UserType.TEACHER:
        return ref.collection('Teachers').document(id);
        break;
      case UserType.PARENT:
        return ref.collection('Parents').document(id);
        break;
      case UserType.UNKNOWN:
        return null;
        break;
      default:
        return null;
    }
  }
}
