import 'package:get_it/get_it.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/core/services/AnnouncementServices.dart';
import 'package:ourESchool/core/services/AuthenticationServices.dart';
import 'package:ourESchool/core/services/ProfileServices.dart';
import 'package:ourESchool/core/services/StorageServices.dart';
import 'package:ourESchool/core/viewmodel/HolidayModel.dart';
import 'package:ourESchool/core/viewmodel/QuizStateModel.dart';
import 'core/services/repository_calendarific.dart';
import 'core/viewmodel/CreateAnnouncementModel.dart';
import 'core/viewmodel/LoginPageModel.dart';
import 'core/viewmodel/ProfilePageModel.dart';

GetIt locator = GetIt();

void setupLocator() {
  // locator.registerLazySingleton(() => MainPageModel());
  // locator.registerSingleton(Services());

  locator.registerLazySingleton(() => AnnouncementServices());
  locator.registerFactory(() => CreateAnnouncementModel());

  locator.registerLazySingleton(() => SharedPreferencesHelper());
  locator.registerFactory(() => QuizStateModel());

  locator.registerLazySingleton(() => RepositoryCalendarific());
  locator.registerFactory(() => HolidayModel());

  locator.registerLazySingleton(() => AuthenticationServices());
  locator.registerFactory(() => LoginPageModel());

  locator.registerLazySingleton(() => ProfileServices());
  locator.registerFactory(() => ProfilePageModel());

  locator.registerLazySingleton(() => StorageServices());
}
