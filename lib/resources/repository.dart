import 'package:acadamicConnect/Models/holiday_data.dart';
import '../helpers/shared_preferences_helper.dart';
import 'calendarific_provider.dart';

class Repository {
  final _calendarificProvider = CalendarificProvider();
  // final _sqliteProvider =SQLiteProvider.db;
  final _sharedPreferencesHelper = SharedPreferencesHelper();

  Future<HolidayData> getHolidays(String countryCode) =>
      _calendarificProvider.getHolidays(countryCode);

  // Future<List<HolidayReminder>> getAllHolidayReminders() => 
  //   _sqliteProvider.getAllHolidays();

  // deleteAllHolidayReminders() =>
  //   _sqliteProvider.deleteAllHolidays();

  // deleteHolidayReminder(String id) => 
  //   _sqliteProvider.deleteHoliday(id);

  // // addNewHolidayReminder(HolidayReminder holidayReminder) =>
  // //   _sqliteProvider.addNewHoliday(holidayReminder);
  
  // Future<bool> isHolidayInReminderList(String id) =>
  //   _sqliteProvider.isHolidayInReminderList(id);

  Future<String> getCountryCode() =>
    _sharedPreferencesHelper.getCountryCode();

  setCountryCode(String countryCode) => 
    _sharedPreferencesHelper.setCountryCode(countryCode);
  
  Future<String> getCountryName() =>
    _sharedPreferencesHelper.getCountryName();

  setCountryName(String countryName) => 
    _sharedPreferencesHelper.setCountryName(countryName);


}
