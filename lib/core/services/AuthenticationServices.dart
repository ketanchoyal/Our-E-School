import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ourESchool/core/Models/User.dart';

class AuthenticationServices {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  User _user;

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

  // Future<FirebaseUser> handleGoogleSignIn() async {
  //   final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;

  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   final FirebaseUser user = await _auth.signInWithCredential(credential);

  //   print("signed in " + user.displayName);
  //   User userr = User(
  //     displayName: user.displayName,
  //     mobileNo: user.phoneNumber,
  //     email: user.email,
  //     firebaseUuid: user.uid,
  //     isVerified: user.isEmailVerified,
  //     photoUrl: user.photoUrl,
  //   );
  //   this._user = userr;
  //   _firebaseUser = user;
  //   return user;
  // }

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
    await _auth.signOut().then((_) async {
      await _googleSignIn.signOut();
    });
    print('User Loged out');
  }
}
