import "dart:async";
import 'dart:async' as prefix0;
import 'dart:io';
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import 'package:flutter/services.dart';
// import "package:google_sign_in/google_sign_in.dart";
import "package:ourESchool/core/Models/User.dart";
import "package:ourESchool/core/Models/UserDataLogin.dart";
import 'package:ourESchool/core/enums/AuthErrors.dart';
import 'package:ourESchool/core/enums/LoginScreenReturnType.dart';
import "package:ourESchool/core/enums/UserType.dart";
import 'package:ourESchool/core/services/Services.dart';
import 'package:ourESchool/locator.dart';

class AuthenticationServices extends Services {
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

  bool isUserLoggedIn = false;
  UserType userType = UserType.STUDENT;

  prefix0.StreamController<FirebaseUser> fireBaseUserStream = StreamController<FirebaseUser>();

  StreamController<bool> isUserLoggedInStream = StreamController<bool>();
  StreamController<UserType> userTypeStream = StreamController<UserType>();

  AuthenticationServices() {
    isLoggedIn().then((onValue) => isUserLoggedIn = onValue);
    _userType().then((onValue) => userType = onValue);
  }

  Future<bool> isLoggedIn() async {
    firebaseUser = await auth.currentUser();
    fireBaseUserStream.add(firebaseUser);
    String name = firebaseUser != null ? firebaseUser.email.toString() : 'Null';
    print('User Email :' + name);
    // if (firebaseUser == null) {
    //   await logoutMethod();
    // }
    isUserLoggedIn = firebaseUser == null ? false : true;
    isUserLoggedInStream.add(isUserLoggedIn);
    print(isUserLoggedIn.toString());
    return isUserLoggedIn;
  }

  Future<UserType> _userType() async {
    userType = await sharedPreferencesHelper.getUserType();
    userTypeStream.add(userType);
    return userType;
  }

  Future checkDetails({
    @required String schoolCode,
    @required String email,
    @required String password,
    @required UserType userType,
  }) async {
    await sharedPreferencesHelper.clearAllData();
    //Check if the School code is present and return "School not Present" if not
    //Then check if the user credentials are in the database or not
    //if not then return "Student Not Found" else return "Logging in"

    //Api Call to check details
    bool isSchoolPresent = false;
    bool isUserAvailable = false;
    String loginType = userType == UserType.STUDENT
        ? "Student"
        : userType == UserType.TEACHER ? "Parent-Teacher" : "Parent-Teacher";

    DocumentReference _schoolLoginRef =
        schoolRef.collection(schoolCode.toUpperCase().trim()).document('Login');

    await _schoolLoginRef.get().then((onValue) {
      isSchoolPresent = onValue.exists;
      print("Inside Then :" + onValue.data.toString());
    });

    if (!isSchoolPresent) {
      print('School Not Found');
      return ReturnType.SCHOOLCODEERROR;
    } else {
      print('School Found');
    }

    CollectionReference _userRef = _schoolLoginRef.collection(loginType);

    await _userRef
        .where("email", isEqualTo: email)
        .snapshots()
        .first
        .then((querySnapshot) {
      querySnapshot.documents.forEach((documentSnapshot) {
        isUserAvailable = documentSnapshot.exists;
        print("User Data : " + documentSnapshot.data.toString());
        if (userType == UserType.STUDENT) {
          userDataLogin = UserDataLogin(
            email: documentSnapshot["email"].toString(),
            id: documentSnapshot["id"].toString(),
            parentIds: documentSnapshot['parentId'] as Map<dynamic, dynamic>,
          );

          // DocumentReference ref = documentSnapshot["ref"] as DocumentReference;
          // print('Insude Document Reference');
          // ref.get().then(
          //       (onValue) => print(
          //         'Dataaa : ' + onValue.data.toString(),
          //       ),
          //     );
        } else {
          userDataLogin = UserDataLogin(
            email: documentSnapshot["email"].toString(),
            id: documentSnapshot["id"].toString(),
            isATeacher: documentSnapshot["isATeacher"] as bool,
            childIds: documentSnapshot["childId"] as Map<dynamic, dynamic>,
          );
        }
      });
    });

    if (!isUserAvailable) {
      print('User Not Found');
      return ReturnType.EMAILERROR;
    } else {
      print('User Found');
      userDataLogin.setData();
    }

    sharedPreferencesHelper.setLoggedInUserId(userDataLogin.id);

    if (userType == UserType.STUDENT) {
      this.userType = userType;
      userTypeStream.add(userType);
      sharedPreferencesHelper.setUserType(UserType.STUDENT);
    } else {
      if (userDataLogin.isATeacher) {
        this.userType = UserType.TEACHER;
        userTypeStream.add(userType);
        sharedPreferencesHelper.setUserType(UserType.TEACHER);
      } else {
        this.userType = UserType.PARENT;
        userTypeStream.add(userType);
        sharedPreferencesHelper.setUserType(UserType.PARENT);
      }
    }

    print("Childs :" + userDataLogin.childIds.toString());
    print("Email :" + userDataLogin.email);
    print("Id :" + userDataLogin.id);
    print("isATeacher :" + userDataLogin.isATeacher.toString());

    return ReturnType.SUCCESS;
  }

  Future emailPasswordRegister(String email, String password, UserType userType,
      String schoolCode) async {
    // await sharedPreferencesHelper.clearAllData();
    try {
      AuthErrors authErrors = AuthErrors.UNKNOWN;
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      authErrors = AuthErrors.SUCCESS;
      sharedPreferencesHelper.setSchoolCode(schoolCode);
      print("User Regestered using Email and Password");
      sharedPreferencesHelper.setUserType(userType);
      isUserLoggedIn = true;
      isUserLoggedInStream.add(isUserLoggedIn);
      return authErrors;
    } catch (e) {
      return catchException(e);
    }
  }

  Future<AuthErrors> emailPasswordSignIn(String email, String password,
      UserType userType, String schoolCode) async {
    // await sharedPreferencesHelper.clearAllData();
    try {
      AuthErrors authErrors = AuthErrors.UNKNOWN;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      authErrors = AuthErrors.SUCCESS;
      sharedPreferencesHelper.setSchoolCode(schoolCode);
      print("User Loggedin using Email and Password");
      sharedPreferencesHelper.setUserType(userType);
      return authErrors;
    } on PlatformException catch (e) {
      return catchException(e);
    }
  }

  Future<User> fetchUserData() async {
    FirebaseUser user = await auth.currentUser();
    if (user == null) {
      print("No User LogedIn");
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
    print(userr.toString());
    return userr;
  }

  logoutMethod() async {
    await auth.signOut();
    isUserLoggedIn = false;
    isUserLoggedInStream.add(isUserLoggedIn);
    await sharedPreferencesHelper.clearAllData();
    print("User Loged out");
  }

  Future<AuthErrors> passwordReset(String email) async {
    try {
      AuthErrors authErrors = AuthErrors.UNKNOWN;
      await auth.sendPasswordResetEmail(email: email);
      authErrors = AuthErrors.SUCCESS;
      print("Password Reset Link Send");
      return authErrors;
    } on PlatformException catch (e) {
      return catchException(e);
    }
  }

  AuthErrors catchException(Exception e) {
    AuthErrors errorType = AuthErrors.UNKNOWN;
    if (e is PlatformException) {
      if (Platform.isIOS) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = AuthErrors.UserNotFound;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = AuthErrors.PasswordNotValid;
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = AuthErrors.NetworkError;
            break;
          // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      } else if (Platform.isAndroid) {
        switch (e.code) {
          case 'Error 17011':
            errorType = AuthErrors.UserNotFound;
            break;
          case 'Error 17009':
            errorType = AuthErrors.PasswordNotValid;
            break;
          case 'Error 17020':
            errorType = AuthErrors.NetworkError;
            break;
          // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      }
    }

    print('The error is $errorType');
    return errorType;
  }
}
