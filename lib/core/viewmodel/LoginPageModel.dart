import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/core/viewmodel/BaseModel.dart';
import 'package:ourESchool/locator.dart';

class LoginPageModel extends BaseModel {
  final _authenticationService = locator<AuthenticationServices>();

  googleLogin() async {
    setState(ViewState.Busy);
    await _authenticationService.handleGoogleSignIn();
    setState(ViewState.Idle);
  }
}