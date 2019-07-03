import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/core/viewmodel/BaseModel.dart';
import 'package:ourESchool/locator.dart';

class LoginPageModel extends BaseModel {
  final _authenticationService = locator<AuthenticationServices>();
  User _loggedInUser;

  User get loggedInUser => _loggedInUser;

  // googleLogin() async {
  //   setState(ViewState.Busy);
  //   await _authenticationService.handleGoogleSignIn();
  //   setState(ViewState.Idle);
  // }

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
