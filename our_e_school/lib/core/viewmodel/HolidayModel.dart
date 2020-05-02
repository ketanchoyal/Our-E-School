import 'package:flutter/material.dart';
import 'package:ourESchool/UI/resources/months_color.dart';
import 'package:ourESchool/core/Models/holiday_data.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/services/repository_calendarific.dart';
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
      // notifyListeners();
      return _holidays;
    }
  }

  HolidayModel() {
    print('HolidayModel Created');
  }

  getHolidays() async {
    setState(ViewState.Busy);
    await getCurrentCuntryCodeAndName();
    _holidays =
        await _repositoryCalendarific.getHolidays(_currentSelectedCountryCode);
    notifyListeners();
    setState(ViewState.Idle);
  }

  refreshHolidays() {
    // _holidays = HolidayData(); //Remove it and try to run
    getHolidays();
    notifyListeners();
  }

  Future getCurrentCuntryCodeAndName() async {
    setState2(ViewState.Busy);
    currentSelectedCountryCode;
    currentSelectedCountryName;
    setState2(ViewState.Idle);
  }

  String get currentSelectedCountryCode {
    if (_currentSelectedCountryCode == null) {
      _repositoryCalendarific.getCountryCode().then((countryCode) {
        _currentSelectedCountryCode = countryCode;
        notifyListeners();
        return _currentSelectedCountryCode;
      });
    }

    return _currentSelectedCountryCode;
  }

  String get currentSelectedCountryName {
    if (_currentSelectedCountryName == null) {
      _repositoryCalendarific.getCountryName().then((countryName) {
        _currentSelectedCountryName = countryName;
        notifyListeners();
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
    notifyListeners();
  }

  Map<String, List<Holiday>> getMapOfMonthToHolidayList(HolidayData data) {
    Map<String, List<Holiday>> monthToHolidayListMap =
        Map<String, List<Holiday>>();

    HolidayData holidayData = data;

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
