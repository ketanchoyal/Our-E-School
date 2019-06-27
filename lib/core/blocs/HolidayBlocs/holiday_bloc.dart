import 'package:acadamicConnect/UI/resources/months_color.dart';
import 'package:acadamicConnect/core/Models/holiday_data.dart';
import 'package:acadamicConnect/core/blocs/HolidayBlocs/repository_calendarific.dart';
import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';

class HolidayBloc {
  final _repository = RepositoryCalendarific();
  final currentSelectedCountryCode = BehaviorSubject<String>();
  final currentSelectedCountryName = BehaviorSubject<String>();
  final holidays = BehaviorSubject<HolidayData>();

  get holidaysValue {
    if (holidays.value != null) {
      return holidays;
    } else {
      getHolidays();
      return holidays;
    }
  }

  getHolidays() async {
    holidays.sink.add(
        await _repository.getHolidays(currentSelectedCountryCodeValue.value));
  }

  refreshHolidays() {
    holidays.sink.add(null);
    getHolidays();
  }

  void dispose() {
    currentSelectedCountryCode.close();
    currentSelectedCountryName.close();
    holidays.close();
  }

  BehaviorSubject<String> get currentSelectedCountryCodeValue {
    if (currentSelectedCountryCode.value == null) {

      _repository.getCountryCode().then((countryCode) {
        currentSelectedCountryCode.sink.add(countryCode);
        return currentSelectedCountryCode;
      });
    }

    return currentSelectedCountryCode;
  }

  BehaviorSubject<String> get currentSelectedCountryNameValue {
    if (currentSelectedCountryName.value == null) {
      _repository.getCountryName().then((countryName) {
        currentSelectedCountryName.sink.add(countryName);
        return currentSelectedCountryName;
      });
    }

    return currentSelectedCountryName;
  }

  setCurrentCountryDetails(
      {@required String countryCode, @required String countryName}) async {
    await _repository.setCountryName(countryName);
    await _repository.setCountryCode(countryCode);

    currentSelectedCountryName.sink.add(countryName);
    currentSelectedCountryCode.sink.add(countryCode);

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

final holidayBloc = HolidayBloc();
