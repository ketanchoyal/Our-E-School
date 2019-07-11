import 'package:get_it/get_it.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/core/viewmodel/HolidayModel.dart';
import 'package:ourESchool/core/viewmodel/QuizStateModel.dart';

import 'core/services/repository_calendarific.dart';
import 'core/viewmodel/LoginPageModel.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => SharedPreferencesHelper());
  locator.registerFactory(() => QuizStateModel());

  locator.registerLazySingleton(() => RepositoryCalendarific());
  locator.registerFactory(() => HolidayModel());

  locator.registerLazySingleton(() => AuthenticationServices());
  locator.registerFactory(() => LoginPageModel());
}
