import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ourESchool/core/Models/Announcement.dart';
import 'package:ourESchool/core/services/Services.dart';
import 'package:ourESchool/core/services/StorageServices.dart';
import 'package:ourESchool/locator.dart';

class AnnouncementServices extends Services {
  StorageServices storageServices = locator<StorageServices>();

  AnnouncementServices() {
    getFirebaseUser();
    getSchoolCode();
  }
  init() async {
    if (firebaseUser == null) await getFirebaseUser();
    if (schoolCode == null) await getSchoolCode();
  }

  postAnnouncement(Announcement announcement) async {
    if (firebaseUser == null) await getFirebaseUser();
    if (schoolCode == null) await getSchoolCode();

    announcement.by = firebaseUser.uid;
    //Timestmap will be directly set by Firebase Functions(througn REST Api)
    // announcement.timestamp = Timestamp.now();

    if (announcement.photoUrl != '') {
      announcement.photoUrl =
          await storageServices.uploadAnnouncemantPhoto(announcement.photoUrl);
    }

    Map announcementMap = announcement.toJson();

    var body = json.encode({
      "schoolCode": schoolCode.toUpperCase(),
      "country": Services.country,
      "announcement": announcementMap
    });

    print(body.toString());

    final response =
        await http.post(postAnnouncemnetUrl, body: body, headers: headers);

    if (response.statusCode == 200) {
      print("Post posted Succesfully");
      print(json.decode(response.body).toString());
    } else {
      print("Post posting failed");
    }
  }
}
