import 'package:get_it/get_it.dart';
import 'package:ourESchool/core/viewmodel/HolidayModel.dart';
import 'package:ourESchool/core/viewmodel/QuizStateModel.dart';
import 'core/blocs/HolidayBlocs/repository_calendarific.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerFactory(() => QuizStateModel());
  locator.registerLazySingleton(() => RepositoryCalendarific());
  locator.registerFactory(() => HolidayModel());
}