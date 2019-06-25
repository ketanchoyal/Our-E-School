import 'package:acadamicConnect/Models/holiday_data.dart';
import 'package:acadamicConnect/blocs/HolidayBlocs/calendarific_ApiCaller.dart';
import '../helpers/shared_preferences_helper.dart';

class RepositoryCalendarific {
  final _calendarificProvider = CalendarificApiCall();
  final _sharedPreferencesHelper = SharedPreferencesHelper();

  Future<HolidayData> getHolidays(String countryCode) =>
      _calendarificProvider.getHolidays(countryCode);

  Future<String> getCountryCode() =>
    _sharedPreferencesHelper.getCountryCode();

  setCountryCode(String countryCode) => 
    _sharedPreferencesHelper.setCountryCode(countryCode);
  
  Future<String> getCountryName() =>
    _sharedPreferencesHelper.getCountryName();

  setCountryName(String countryName) => 
    _sharedPreferencesHelper.setCountryName(countryName);

}
