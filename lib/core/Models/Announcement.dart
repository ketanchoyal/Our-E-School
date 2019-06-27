

import 'package:ourESchool/core/enums/announcementType.dart';

class Announcement {
  String by;
  String id;
  // String title;
  String timestamp;
  AnnouncementType type;
  // String content;
  String caption;
  String photoUrl;
  String forClass;
  String forDiv;

  Announcement({this.by, this.caption, this.forClass, this.id, this.photoUrl, this.timestamp, this.type, this.forDiv});
}