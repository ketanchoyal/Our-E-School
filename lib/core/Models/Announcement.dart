import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ourESchool/core/enums/announcementType.dart';

class Announcement {
  String caption;
  String by;
  String forDiv;
  Timestamp timestamp;
  String forClass;
  String photoUrl;
  String photoPath;
  AnnouncementType type;
  String id;

  Announcement(
      {this.caption = '',
      this.by,
      this.forDiv,
      this.timestamp,
      this.forClass,
      this.photoUrl = '',
      this.photoPath = '',
      this.type,
      this.id});

  Announcement.fromJson(Map<String, dynamic> json) {
    caption = json['caption'] ?? '';
    by = json['by'];
    forDiv = json['forDiv'];
    timestamp = json['timestamp'] as Timestamp;
    forClass = json['forClass'];
    photoUrl = json['photoUrl'] ?? '';
    photoPath = json['photoPath'] ?? '';
    type = AnnouncementTypeHelper.getEnum(json['type']);
    id = json['id'];
  }

  Announcement.fromSnapshot(DocumentSnapshot snapshot) {
    caption = snapshot['caption'].toString() ?? '';
    by = snapshot['by'].toString();
    forDiv = snapshot['forDiv'].toString();
    timestamp = snapshot['timeStamp'] as Timestamp;
    forClass = snapshot['forClass'].toString();
    photoUrl = snapshot['photoUrl'].toString() ?? '';
    photoPath = snapshot['photoPath'].toString() ?? '';
    type = AnnouncementTypeHelper.getEnum(snapshot['type'].toString());
    id = snapshot.id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caption'] = this.caption;
    data['by'] = this.by;
    data['forDiv'] = this.forDiv;
    // data['timestamp'] = this.timestamp;
    data['forClass'] = this.forClass;
    data['photoUrl'] = this.photoUrl;
    data['type'] = AnnouncementTypeHelper.getValue(this.type);
    data['photoPath'] = this.photoPath;
    // data['id'] = this.id;
    return data;
  }
}
