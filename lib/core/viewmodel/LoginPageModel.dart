import 'package:ourESchool/core/Models/User.dart';
import 'package:ourESchool/core/enums/UserType.dart';
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

  Future loginUser({
    String schoolCode,
    String email,
    String password,
    UserType userType,
  }) async {
    String response = await _authenticationService.checkDetails(
        email: email,
        password: password,
        schoolCode: schoolCode,
        userType: userType);

    return response;
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
