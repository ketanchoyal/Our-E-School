import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ourESchool/core/Models/User.dart';

class AuthenticationServices {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  User _user;

  FirebaseUser get firebaseUser => _firebaseUser;
  User get loggedInUser => _user;

  Future<FirebaseUser> handleGoogleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);

    print("signed in " + user.displayName);
    User userr = User(
      displayName: user.displayName,
      mobileNo: user.phoneNumber,
      email: user.email,
      firebaseUuid: user.uid,
      isVerified: user.isEmailVerified,
      photoUrl: user.photoUrl,
    );
    this._user = userr;
    _firebaseUser = user;
    return user;
  }

  // Future handleGoogleSignIn() async {
  //   AuthCredential credential;
  //   final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication.then((onValue) async {
  //     credential = GoogleAuthProvider.getCredential(
  //       accessToken: onValue.accessToken,
  //       idToken: onValue.idToken,
  //     );
  //     _firebaseUser = await _auth.signInWithCredential(credential);
  //   });

  //   // final AuthCredential credential = GoogleAuthProvider.getCredential(
  //   //   accessToken: googleAuth.accessToken,
  //   //   idToken: googleAuth.idToken,
  //   // );

  //   // final FirebaseUser user = await _auth.signInWithCredential(credential);

  //   print("signed in " + _firebaseUser.displayName);
  //   User user = User(
  //     displayName: _firebaseUser.displayName,
  //     mobileNo: _firebaseUser.phoneNumber,
  //     email: _firebaseUser.email,
  //     firebaseUuid: _firebaseUser.uid,
  //     isVerified: _firebaseUser.isEmailVerified,
  //     photoUrl: _firebaseUser.photoUrl,
  //   );
  //   this._user = user;
  // }
}
