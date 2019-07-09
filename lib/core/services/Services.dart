import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/Models/UserDataLogin.dart';

class Services {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  FirebaseUser _firebaseUser;
  User _user;
  UserDataLogin userDataLogin;

  Firestore get firestore => _firestore;
  FirebaseAuth get auth => _auth;
  FirebaseUser get firebaseUser => _firebaseUser;
  User get loggedInUser => _user;
}
