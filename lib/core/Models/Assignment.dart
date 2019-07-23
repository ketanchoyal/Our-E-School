import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  String by;
  String path;
  String div;
  String subject;
  String standard;
  Timestamp timeStamp;
  String url;
  String details;
  String id;

  Assignment(
      {this.by,
      this.path,
      this.div,
      this.subject,
      this.standard,
      this.timeStamp,
      this.url,
      this.details,
      this.id});

  Assignment.fromJson(Map<String, dynamic> json) {
    by = json['by'];
    path = json['path'];
    div = json['div'];
    subject = json['subject'];
    standard = json['standard'];
    timeStamp = json['timeStamp'] as Timestamp ?? null;
    url = json['url'];
    details = json['details'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['path'] = this.path;
    data['div'] = this.div;
    data['subject'] = this.subject;
    data['standard'] = this.standard;
    data['url'] = this.url;
    data['details'] = this.details;
    data['id'] = this.id;
    return data;
  }
}
