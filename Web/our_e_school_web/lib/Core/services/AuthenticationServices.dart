import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:oureschoolweb/Core/enums/AuthErrors.dart';
import 'package:oureschoolweb/Core/enums/LoginScreenReturnType.dart';
import 'package:oureschoolweb/Core/enums/UserType.dart';
// import 'package:oureschoolweb/Core/services/ProfileServices.dart';
import 'package:oureschoolweb/Core/services/Services.dart';
import 'package:oureschoolweb/locator.dart';

class AuthenticationServices extends Services {

  // ProfileServices _profileServices = locator<ProfileServices>();

  AuthenticationServices() {
    firestore.settings(
      persistenceEnabled: false,
    );
  }

  Future<bool> isLoggedIn() async {
  }

  Future<UserType> _userType() async {
  }

  Future checkDetails({
    @required String schoolCode,
    @required String email,
    @required String password,
    @required UserType userType,
  }) async {
    
  }

  Future emailPasswordRegister(String email, String password, UserType userType,
      String schoolCode) async {
    // await sharedPreferencesHelper.clearAllData();
    try {
    } catch (e) {
      return catchException(e);
    }
  }

  Future<AuthErrors> emailPasswordSignIn(String email, String password,
      UserType userType, String schoolCode) async {
    // await sharedPreferencesHelper.clearAllData();
    try {
    } on PlatformException catch (e) {
      return catchException(e);
    }
  }

  logoutMethod() async {
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
          case 'Too many unsuccessful login attempts.  Please include reCaptcha verification or try again later':
            errorType = AuthErrors.TOOMANYATTEMPTS;
            break;
          // ...
          default:
            print('Case iOS ${e.message} is not yet implemented');
        }
      } else if (Platform.isAndroid) {
        switch (e.code) {
          case 'Error 17011':
            errorType = AuthErrors.UserNotFound;
            break;
          case 'Error 17009':
          case 'ERROR_WRONG_PASSWORD':
            errorType = AuthErrors.PasswordNotValid;
            break;
          case 'Error 17020':
            errorType = AuthErrors.NetworkError;
            break;
          // ...
          default:
            print('Case Android ${e.message} ${e.code} is not yet implemented');
        }
      }
    }

    print('The error is $errorType');
    return errorType;
  }
}
