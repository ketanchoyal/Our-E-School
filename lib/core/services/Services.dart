import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/Models/UserDataLogin.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/locator.dart';

class Services {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static Firestore _firestore = Firestore.instance;
  FirebaseUser firebaseUser;
  User _user;
  UserDataLogin userDataLogin;
  DocumentReference _schoolRef = _firestore.collection('School').document('India');

  Firestore get firestore => _firestore;
  FirebaseAuth get auth => _auth;
  // FirebaseUser get firebaseUser => _firebaseUser;
  User get loggedInUser => _user;
  DocumentReference get schoolRef => _schoolRef;

  SharedPreferencesHelper _sharedPreferencesHelper =
      locator<SharedPreferencesHelper>();

  SharedPreferencesHelper get sharedPreferencesHelper =>
      _sharedPreferencesHelper;
  // init() {
  //   _auth.currentUser().then((onValue) => _firebaseUser = onValue);
  //   print('Here');
  // }

  DocumentSnapshot getProfileRef(String id, UserType userType) {

    // DocumentReference ref = 
  }

}
