import 'package:ourESchool/imports.dart';

class Message {
  String to;
  String from;
  String message;
  Timestamp timeStamp;
  String id;
  String for_;

  Message({this.to, this.from, this.message, this.timeStamp, this.for_});

  Message.fromSnapShot(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    _fromJson(snapshot.data());
  }

  Message.fromJson(Map<String, dynamic> json) {
    _fromJson(json);
  }

  _fromJson(Map<String, dynamic> json) {
    this.to = json['to'];
    this.for_ = json['for'];
    this.from = json['from'];
    this.message = json['message'].toString();
    this.timeStamp = json['timestamp'] as Timestamp;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['for'] = this.for_;
    data['to'] = this.to;
    data['from'] = this.from;
    data['timestamp'] = this.timeStamp;
    data['message'] = this.message;
    return data;
  }
}
