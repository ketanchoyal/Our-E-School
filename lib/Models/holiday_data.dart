// To parse this JSON data, do
//
//     final holidays = holidaysFromJson(jsonString);

import 'dart:convert';

HolidayData holidaysFromJson(String str) {
  final jsonData = json.decode(str);
  return HolidayData.fromJson(jsonData);
}

String holidaysToJson(HolidayData data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class HolidayData {
  Meta meta;
  Response response;

  HolidayData({
    this.meta,
    this.response,
  });

  factory HolidayData.fromJson(Map<String, dynamic> json) => new HolidayData(
        meta: Meta.fromJson(json["meta"]),
        response: Response.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "response": response.toJson(),
      };
}

class Meta {
  int code;

  Meta({
    this.code,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => new Meta(
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}

class Response {
  List<Holiday> holidays;

  Response({
    this.holidays,
  });

  factory Response.fromJson(Map<String, dynamic> json) => new Response(
        holidays: new List<Holiday>.from(
          (json["response"]["holidays"]).map(
            (x) => Holiday.fromJson(x),
          ),
        ), //ignore: _TypeError
      );

  Map<String, dynamic> toJson() => {
        "holidays": new List<dynamic>.from(holidays.map((x) => x.toJson())),
      };
}

class Holiday {
  String name;
  String description;
  Date date;
  List<Type> type;
  Locations locations;
  Locations states;
  bool isExpanded;

  Holiday({
    this.name,
    this.description,
    this.date,
    this.type,
    this.locations,
    // this.states,
    this.isExpanded = false,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) => new Holiday(
        name: json["name"],
        description: json["description"] == null ? null : json["description"],
        date: Date.fromJson(json["date"]),
        type: new List<Type>.from(json["type"].map((x) => typeValues.map[x])),
        locations: locationsValues.map[json["locations"]],
        // states: locationsValues.map[json["states"]],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description == null ? null : description,
        "date": date.toJson(),
        "type": new List<dynamic>.from(type.map((x) => typeValues.reverse[x])),
        "locations": locationsValues.reverse[locations],
        // "states": locationsValues.reverse[states],
      };
}

class Date {
  String iso;
  Datetime datetime;
  Timezone timezone;

  Date({
    this.iso,
    this.datetime,
    this.timezone,
  });

  factory Date.fromJson(Map<String, dynamic> json) => new Date(
        iso: json["iso"],
        datetime: Datetime.fromJson(json["datetime"]),
        timezone: json["timezone"] == null
            ? null
            : Timezone.fromJson(json["timezone"]),
      );

  Map<String, dynamic> toJson() => {
        "iso": iso,
        "datetime": datetime.toJson(),
        "timezone": timezone == null ? null : timezone.toJson(),
      };
}

class Datetime {
  int year;
  int month;
  int day;
  int hour;
  int minute;
  int second;

  Datetime({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
  });

  factory Datetime.fromJson(Map<String, dynamic> json) => new Datetime(
        year: json["year"],
        month: json["month"],
        day: json["day"],
        hour: json["hour"] == null ? null : json["hour"],
        minute: json["minute"] == null ? null : json["minute"],
        second: json["second"] == null ? null : json["second"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "day": day,
        "hour": hour == null ? null : hour,
        "minute": minute == null ? null : minute,
        "second": second == null ? null : second,
      };
}

class Timezone {
  String offset;
  String zoneabb;
  int zoneoffset;
  int zonedst;
  int zonetotaloffset;

  Timezone({
    this.offset,
    this.zoneabb,
    this.zoneoffset,
    this.zonedst,
    this.zonetotaloffset,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) => new Timezone(
        offset: json["offset"],
        zoneabb: json["zoneabb"],
        zoneoffset: json["zoneoffset"],
        zonedst: json["zonedst"],
        zonetotaloffset: json["zonetotaloffset"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "zoneabb": zoneabb,
        "zoneoffset": zoneoffset,
        "zonedst": zonedst,
        "zonetotaloffset": zonetotaloffset,
      };
}

enum Locations { ALL }

final locationsValues = new EnumValues({"All": Locations.ALL});

enum Type { NATIONAL_HOLIDAY, LOCAL_HOLIDAY, OBSERVANCE, SEASON, CHRISTIAN }

final typeValues = new EnumValues({
  "Christian": Type.CHRISTIAN,
  "Local holiday": Type.LOCAL_HOLIDAY,
  "National holiday": Type.NATIONAL_HOLIDAY,
  "Observance": Type.OBSERVANCE,
  "Season": Type.SEASON
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
