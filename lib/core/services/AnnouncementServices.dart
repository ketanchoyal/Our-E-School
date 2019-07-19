import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ourESchool/core/Models/Announcement.dart';
import 'package:ourESchool/core/services/Services.dart';

class AnnouncementServices extends Services {
  AnnouncementServices() {}

  postAnnouncement(Announcement announcement) async {
    Map announcementMap = announcement.toJson();

    var body = json.encode({
      "schoolCode": schoolCode,
      "country": Services.country,
      "announcement": announcementMap
    });

    final response = await http.post(
      postAnnouncemnetUrl,
      body: body,
      headers: headers
    );

    if (response.statusCode == 200) {
      print("Post posted Succesfully");
      print(json.decode(response.body).toString());
    } else {
      print("Post posting failed");
    }
  }
}
