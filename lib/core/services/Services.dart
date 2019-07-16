import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/Models/UserDataLogin.dart';
import 'package:ourESchool/core/Server.dart';
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

  DocumentReference _schoolRef =
      _firestore.collection('Schools').document('India');

  Firestore get firestore => _firestore;
  FirebaseAuth get auth => _auth;
  User get loggedInUser => _user;

  DocumentReference get schoolRef => _schoolRef;

  StorageReference get storageReference => _storageReference;

  SharedPreferencesHelper get sharedPreferencesHelper =>
      _sharedPreferencesHelper;
}
