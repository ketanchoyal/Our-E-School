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

  // MainPageModel() {
  //   print("In Main Model : " + isUserLoggedIn.toString());
  //   setState(ViewState.Busy);
  //   _getUserType();
  //   _isUserLoggedInCheck();
  //   setState(ViewState.Idle);
  //   print("In Main Model : " + isUserLoggedIn.toString());
  // }

  MainPageModel.initials() {
    // print("In Main Model : " + isUserLoggedIn.toString());
    setState(ViewState.Busy);
    _getUserType();
    _isUserLoggedInCheck();
    setState(ViewState.Idle);
    // print("In Main Model : " + isUserLoggedIn.toString());
  }

  _isUserLoggedInCheck() async {
    isUserLoggedIn = await _authenticationService.isLoggedIn();
    print("User Loggedin : " + isUserLoggedIn.toString());
  }

  _getUserType() async {
    userType =
        await _authenticationService.sharedPreferencesHelper.getUserType();
  }

  // bool isUserLoggedIn() {
  //   return _authenticationService.isUserLoggedIn;
  // }
}
