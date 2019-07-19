import 'package:ourESchool/core/enums/announcementType.dart';

// class Announcement {
//   String by;
//   String id;
//   // String title;
//   String timestamp;
//   AnnouncementType type;
//   // String content;
//   String caption;
//   String photoUrl;
//   String forClass;
//   String forDiv;

//   Announcement({this.by, this.caption, this.forClass, this.id, this.photoUrl, this.timestamp, this.type, this.forDiv});
// }

class Announcement {
  String caption;
  String by;
  String forDiv;
  String timestamp;
  String forClass;
  String photoUrl;
  AnnouncementType type;
  String id;

  Announcement(
      {this.caption = '',
      this.by,
      this.forDiv,
      this.timestamp,
      this.forClass,
      this.photoUrl = '',
      this.type,
      this.id});

  Announcement.fromJson(Map<String, dynamic> json) {
    caption = json['caption'] ?? '';
    by = json['by'];
    forDiv = json['forDiv'];
    timestamp = json['timestamp'];
    forClass = json['forClass'];
    photoUrl = json['photoUrl'] ?? '';
    type = AnnouncementTypeHelper.getEnum(json['type']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caption'] = this.caption;
    data['by'] = this.by;
    data['forDiv'] = this.forDiv;
    data['timestamp'] = this.timestamp;
    data['forClass'] = this.forClass;
    data['photoUrl'] = this.photoUrl;
    data['type'] = AnnouncementTypeHelper.getValue(this.type);
    data['id'] = this.id;
    return data;
  }
}
