import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/AuthErrors.dart';
import 'package:ourESchool/core/enums/ButtonType.dart';
import 'package:ourESchool/core/enums/LoginScreenReturnType.dart';
import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/core/viewmodel/BaseModel.dart';
import 'package:ourESchool/locator.dart';

class LoginPageModel extends BaseModel {
  final _authenticationService = locator<AuthenticationServices>();
  User _loggedInUser;
  String currentLoggingStatus = 'Please wait';

  User get loggedInUser => _loggedInUser;

  // googleLogin() async {
  //   setState(ViewState.Busy);
  //   await _authenticationService.handleGoogleSignIn();
  //   setState(ViewState.Idle);
  // }

  Future checkUserDetails({
    String schoolCode,
    String email,
    String password,
    String confirmPassword,
    UserType userType,
    ButtonType buttonType,
  }) async {
    setState(ViewState.Busy);
    ReturnType response = await _authenticationService.checkDetails(
        email: email,
        password: password,
        schoolCode: schoolCode,
        userType: userType);

    if (response == ReturnType.EMAILERROR) {
      currentLoggingStatus = 'No user with that email found';
      setState(ViewState.Idle);
      return false;
    } else if (response == ReturnType.SCHOOLCODEERROR) {
      currentLoggingStatus = 'No school with that code found';
      //can add delay of 2 sec to show error message
      setState(ViewState.Idle);
      return false;
    } else {
      currentLoggingStatus = 'Please wait while we check your credientials..';
      if (buttonType == ButtonType.LOGIN) {
        AuthErrors res = await loginUser(email, password, userType);
        setState(ViewState.Idle);
        if (res == AuthErrors.SUCCESS) {
          return true;
        } else {
          return false;
        }
      } else {
        if (password != confirmPassword) {
          currentLoggingStatus = 'Passwords do not match';
          setState(ViewState.Idle);
          return false;
        }
        AuthErrors res = await registerUser(email, password, userType);
        setState(ViewState.Idle);
        if (res == AuthErrors.SUCCESS) {
          return true;
        } else {
          return false;
        }
      }
    }
  }

  Future loginUser(String email, String password, UserType userType) async {
    AuthErrors authError = await _authenticationService.emailPasswordSignIn(
        email, password, userType);
    currentLoggingStatus = AuthErrorsHelper.getValue(authError);
    return authError;
  }

  Future registerUser(String email, String password, UserType userType) async {
    AuthErrors authError = await _authenticationService.emailPasswordRegister(
        email, password, userType);
    currentLoggingStatus = AuthErrorsHelper.getValue(authError);
    return authError;
  }

  getUserData() async {
    setState(ViewState.Busy);
    _loggedInUser = await _authenticationService.fetchUserData();
    setState(ViewState.Idle);
  }

  logoutUser() {
    setState(ViewState.Busy);
    _authenticationService.logoutMethod();
    setState(ViewState.Idle);
  }
}
