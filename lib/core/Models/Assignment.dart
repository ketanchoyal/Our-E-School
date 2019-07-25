import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  String by;
  String path;
  String div;
  String subject;
  String standard;
  Timestamp timeStamp;
  String url;
  String type;
  String details;
  String id;
  String title;

  Assignment(
      {this.by,
      this.title,
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
    title = json['title'];
    div = json['div'];
    subject = json['subject'];
    type = json['type'];
    standard = json['standard'];
    timeStamp = json['timeStamp'] as Timestamp ?? null;
    url = json['url'];
    details = json['details'];
    id = json['id'];
  }

  Assignment.fromSnapshot(DocumentSnapshot documentSnapshot) {
    by = documentSnapshot['by'].toString();
    title = documentSnapshot['title'].toString();
    path = documentSnapshot['path'].toString();
    div = documentSnapshot['div'].toString();
    subject = documentSnapshot['subject'].toString();
    type = documentSnapshot['type'].toString();
    standard = documentSnapshot['standard'].toString();
    timeStamp = documentSnapshot['timeStamp'] as Timestamp ?? null;
    url = documentSnapshot['url'].toString();
    details = documentSnapshot['details'].toString();
    id = documentSnapshot.documentID;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['path'] = this.path;
    data['title'] = this.title;
    data['div'] = this.div;
    data['type'] = this.type;
    data['subject'] = this.subject;
    data['standard'] = this.standard;
    data['url'] = this.url;
    data['details'] = this.details;
    return data;
  }
}
