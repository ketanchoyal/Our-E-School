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
    this.to = snapshot['to'].toString();
    this.for_ = snapshot['for'].toString();
    this.from = snapshot['from'].toString();
    this.id = snapshot.documentID;
    this.message = snapshot['message'].toString();
    this.timeStamp = snapshot['timeStamp'] as Timestamp;
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
