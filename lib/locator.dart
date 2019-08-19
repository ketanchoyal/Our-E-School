import 'package:get_it/get_it.dart';
import 'imports.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // locator.registerLazySingleton(() => MainPageModel());
  // locator.registerSingleton(Services());

  locator.registerLazySingleton(() => AnnouncementServices());
  locator.registerFactory(() => CreateAnnouncementModel());
  locator.registerFactory(() => AnnouncementPageModel());

  locator.registerLazySingleton(() => SharedPreferencesHelper());
  locator.registerFactory(() => QuizStateModel());

  locator.registerLazySingleton(() => RepositoryCalendarific());
  locator.registerFactory(() => HolidayModel());

  locator.registerLazySingleton(() => AuthenticationServices());
  locator.registerFactory(() => LoginPageModel());

  locator.registerLazySingleton(() => ProfileServices());
  locator.registerLazySingleton(() => ProfilePageModel());

  locator.registerLazySingleton(() => StorageServices());

  locator.registerLazySingleton(() => AssignmentServices());
  locator.registerFactory(() => AssignmentPageModel());

  locator.registerLazySingleton(() => ChatServices());
  locator.registerFactory(() => ChatUsersListPageModel());
  locator.registerFactory(() => MessagingScreenPageModel());
}
