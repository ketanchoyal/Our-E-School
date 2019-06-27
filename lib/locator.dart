import 'package:get_it/get_it.dart';
import 'package:ourESchool/core/viewmodel/QuizStateModel.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerFactory(() => QuizStateModel());
}