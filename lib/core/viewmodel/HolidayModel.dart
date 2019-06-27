import 'package:flutter/material.dart';
import 'package:ourESchool/UI/resources/months_color.dart';
import 'package:ourESchool/core/Models/holiday_data.dart';
import 'package:ourESchool/core/blocs/HolidayBlocs/repository_calendarific.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/core/viewmodel/BaseModel.dart';
import 'package:ourESchool/locator.dart';

class HolidayModel extends BaseModel {
  final _repositoryCalendarific = locator<RepositoryCalendarific>();
  HolidayData _holidays;
  String _currentSelectedCountryCode;
  String _currentSelectedCountryName;

  get holidaysValue {
    if (_holidays != null) {
      return _holidays;
    } else {
      getHolidays();
      return _holidays;
    }
  }

  getHolidays() async {
    _holidays = await _repositoryCalendarific
        .getHolidays(await currentSelectedCountryCode);
  }

  refreshHolidays() {
    _holidays = HolidayData(); //Remove it and try to run
    getHolidays();
  }

  Future<String> get currentSelectedCountryCode async {
    if (_currentSelectedCountryCode == null) {
      await _repositoryCalendarific.getCountryCode().then((countryCode) {
        _currentSelectedCountryCode = countryCode;
        return _currentSelectedCountryCode;
      });
    }

    return _currentSelectedCountryCode;
  }

  Future<String> get currentSelectedCountryName async {
    if (_currentSelectedCountryName == null) {
      await _repositoryCalendarific.getCountryName().then((countryName) {
        _currentSelectedCountryName = countryName;
        return _currentSelectedCountryName;
      });
    }

    return _currentSelectedCountryName;
  }

  setCurrentCountryDetails(
      {@required String countryCode, @required String countryName}) async {
    await _repositoryCalendarific.setCountryName(countryName);
    await _repositoryCalendarific.setCountryCode(countryCode);

    _currentSelectedCountryName = countryName;
    _currentSelectedCountryCode = countryCode;

    refreshHolidays();
  }

  Map<String, List<Holiday>> getMapOfMonthToHolidayList(
      AsyncSnapshot snapshot) {
    Map<String, List<Holiday>> monthToHolidayListMap =
        Map<String, List<Holiday>>();

    HolidayData holidayData = snapshot.data;

    if (holidayData == null) {
      return monthToHolidayListMap;
    }
    Response response = holidayData.response;

    List<Holiday> holidays = response.holidays;

    monthToColorMap.forEach((month, color) {
      int monthPosition = monthToColorMap.keys.toList().indexOf(month) + 1;

      List<Holiday> monthHolidaysList = List();
      holidays.forEach((holiday) {
        if (holiday.date.datetime.month == monthPosition) {
          monthHolidaysList.add(holiday);
        }
        monthToHolidayListMap[month] = monthHolidaysList;
      });
    });

    return monthToHolidayListMap;
  }
}
