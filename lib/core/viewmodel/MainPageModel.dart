import 'package:ourESchool/core/enums/UserType.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/core/viewmodel/BaseModel.dart';
import 'package:ourESchool/locator.dart';

class MainPageModel extends BaseModel {
  AuthenticationServices _authenticationService =
      locator<AuthenticationServices>();

  bool isUserLoggedIn = false;
  UserType userType = UserType.UNKNOWN;

  MainPageModel() {
    getUserType();
    isUserLoggedInCheck();
  }

  isUserLoggedInCheck() async {
    setState(ViewState.Busy);
    isUserLoggedIn = await _authenticationService.isLoggedIn();
    setState(ViewState.Idle);
    print("In Main Model : " + isUserLoggedIn.toString());
  }

  getUserType() async {
    await _authenticationService.sharedPreferencesHelper.getUserType();
  }

  // bool isUserLoggedIn() {
  //   return _authenticationService.isUserLoggedIn;
  // }
}
