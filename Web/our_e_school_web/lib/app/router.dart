import 'package:auto_route/auto_route_annotations.dart';
import 'package:oureschoolweb/ui/pages/add_user/add_user.dart';
import 'package:oureschoolweb/ui/pages/home_page.dart';
import 'package:oureschoolweb/ui/pages/login/login_page.dart';
import 'package:oureschoolweb/ui/pages/register/register_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  HomePage homePage;
  LoginPage loginPage;
  RegisterPage registerPage;
  AddUser addUser;
}
