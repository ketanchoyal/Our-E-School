import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:ourESchool/core/Models/User.dart';

class AuthenticationServices {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
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

  Future<String> checkDetails(
      {String schoolCode, String email, String password}) async {
    //Check if the School code is present and return 'School not Present' if not
    //Then check if the user credentials are in the database or not
    //if not then return 'Student Not Fount' else return 'Logging in'
    String detailCheckStatus = '';
    //Api Call to check details
    bool isSchoolPresent = false;
    bool isStudentPresent = false;

    if (isSchoolPresent) {
      if (isStudentPresent) {
        _emailPasswordSignIn(email, password);
      } else {
        detailCheckStatus = 'Student Not Present';
      }
    } else {
      detailCheckStatus = 'Please Enter correct SchoolCode';
    }

    return detailCheckStatus;
  }

  Future _emailPasswordSignIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    print('User Loggedin using Email and Password');
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
