import 'package:oureschoolweb/app/locator.dart';
import 'package:oureschoolweb/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BaseViewModelExtended extends BaseViewModel {
  static NavigationService _navigationService = locator<NavigationService>();

  Future navigateToHome() async {
    await _navigationService.navigateTo(Routes.homePage);
  }

  Future navigateToLogin() async {
    await _navigationService.navigateTo(Routes.loginPage);
  }

  Future navigateToRegister() async {
    await _navigationService.navigateTo(Routes.registerPage);
  }

  Future navigateToAddUser() async {
    await _navigationService.navigateTo(Routes.addUser);
  }
}
