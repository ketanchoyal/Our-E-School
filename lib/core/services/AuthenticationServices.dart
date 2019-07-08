import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/Models/UserDataLogin.dart';
import 'package:ourESchool/core/enums/UserType.dart';

class AuthenticationServices {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  User _user;
  Firestore _firestore = Firestore.instance;
  // UserType _userType;
  UserDataLogin _userDataLogin;

  FirebaseUser get firebaseUser => _firebaseUser;
  User get loggedInUser => _user;

  // Future handleGoogleSignIn() async {
  //   try {
  //     AuthCredential credential;
  //     final GoogleSignInAccount googleUser = await _googleSignIn.signIn().catchError((e) {
  //       throw e;
  //     });
  //     await googleUser.authentication.then((onValue) async {
  //       credential = GoogleAuthProvider.getCredential(
  //         accessToken: onValue.accessToken,
  //         idToken: onValue.idToken,
  //       );
  //       _firebaseUser = await _auth.signInWithCredential(credential);
  //     });
  //     print("signed in " + _firebaseUser.displayName);
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<String> checkDetails({
    @required String schoolCode,
    @required String email,
    @required String password,
    @required UserType userType,
  }) async {
    //Check if the School code is present and return 'School not Present' if not
    //Then check if the user credentials are in the database or not
    //if not then return 'Student Not Found' else return 'Logging in'
    String country = 'India';
    //Api Call to check details
    bool isSchoolPresent = false;
    bool isUserAvailable = false;
    String loginType = userType == UserType.STUDENT
        ? 'Students'
        : userType == UserType.TEACHER ? 'Parent-Teacher' : 'Parent-Teacher';

    CollectionReference _schoolRef = _firestore
        .collection('Schools')
        .document(country)
        .collection(schoolCode);

    isSchoolPresent = await _schoolRef.snapshots().isEmpty;

    if (!isSchoolPresent) {
      return 'Please Enter correct SchoolCode';
    }

    CollectionReference _userRef =
        _schoolRef.document('Login').collection(loginType);

    Stream<QuerySnapshot> studentSnapshot =
        _userRef.where('email', isEqualTo: email).snapshots();

    print('Student Data : ' + studentSnapshot.toList().toString());

    isUserAvailable = await studentSnapshot.isEmpty;

    if (isUserAvailable) {
      return 'Student Not Found';
    }

    await studentSnapshot.first.then((onValue) {
      onValue.documents.map((DocumentSnapshot document) {
        if (userType == UserType.STUDENT) {
          _userDataLogin = UserDataLogin(
            email: document['email'].toString(),
            id: document['id'].toString(),
          );
        } else {
          _userDataLogin = UserDataLogin(
            email: document['email'].toString(),
            id: document['id'].toString(),
            isATeacher: document['isATeacher'] as bool,
            childIds: document['chilsId'] as List,
          );
        }
      });
    });

    print('Childs :' + _userDataLogin.childIds.toString());
    print('Email :' + _userDataLogin.email);
    print('Id :' + _userDataLogin.id);
    print('isATeacher :' + _userDataLogin.isATeacher.toString());

    // _emailPasswordSignIn(email, password);

    return 'Please wait while we check your credientials';
  }

  Future _emailPasswordSignIn(String email, String password) async {
    bool successLogin = false;
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .whenComplete(() => successLogin = true);
    print('User Loggedin using Email and Password');

    return successLogin;
  }

  Future<User> fetchUserData() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      print('No User LogedIn');
      return null;
    }
    User userr = User(
      displayName: user.displayName,
      mobileNo: user.phoneNumber,
      email: user.email,
      firebaseUuid: user.uid,
      isVerified: user.isEmailVerified,
      photoUrl: user.photoUrl,
    );
    return userr;
  }

  logoutMethod() async {
    await _auth.signOut();
    print('User Loged out');
  }
}
