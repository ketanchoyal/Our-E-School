import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String photoUrl;
  String email;
  String division;
  String id;
  String enrollNo;
  String firebaseUuid;
  String displayName;
  String standard;
  String dob;
  String guardianName;
  String bloodGroup;
  String mobileNo;
  bool isTeacher;
  bool isVerified;
  // Map<String, dynamic> connection;
  var connection;

  String standardDivision() {
    return standard + division.toUpperCase();
  }

  AppUser(
      {this.photoUrl = 'default',
      this.email = '',
      this.division = '',
      this.id = '',
      this.enrollNo = '',
      this.firebaseUuid = '',
      this.connection = null,
      this.displayName = '',
      this.standard = '',
      this.dob = '',
      this.guardianName = '',
      this.bloodGroup = '',
      this.mobileNo = '',
      this.isTeacher = false,
      this.isVerified = false});

  bool isEmpty() {
    if (this.displayName == '') return true;

    if (this.division == '') return true;

    if (this.standard == '') return true;

    if (this.guardianName == '') return true;

    return false;
  }

  AppUser.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _fromJson(documentSnapshot.data());
  }

  _fromJson(Map<String, dynamic> json) {
    photoUrl = json['photoUrl'] ?? 'default';
    email = json['email'] ?? '';
    division = json['division'] ?? '';
    id = json['id'] ?? '';
    enrollNo = json['enrollNo'] ?? '';
    firebaseUuid = json['firebaseUuid'] ?? '';
    displayName = json['displayName'] ?? '';
    standard = json['standard'] ?? '';
    dob = json['dob'] ?? '';
    guardianName = json['guardianName'] ?? '';
    bloodGroup = json['bloodGroup'] ?? '';
    mobileNo = json['mobileNo'] ?? '';
    isTeacher = json['isTeacher'] ?? false;
    isVerified = json['isVerified'] ?? false;
    connection = json['connection'] ?? {};
  }

  AppUser.fromJson(Map<String, dynamic> json) {
    _fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoUrl'] = this.photoUrl;
    data['email'] = this.email;
    data['division'] = this.division.toUpperCase().trim();
    data['id'] = this.id;
    data['enrollNo'] = this.enrollNo;
    data['firebaseUuid'] = this.firebaseUuid;
    data['displayName'] = this.displayName;
    data['standard'] = this.standard;
    data['dob'] = this.dob;
    data['guardianName'] = this.guardianName;
    data['bloodGroup'] = this.bloodGroup;
    data['mobileNo'] = this.mobileNo;
    data['isTeacher'] = this.isTeacher;
    data['isVerified'] = this.isVerified;
    data['connection'] = this.connection;
    return data;
  }
}

// List<User> users = [
//   User(
//       displayName: "Name Surname",
//       division: "A",
//       standard: "9",
//       photoUrl:
//           "https://www.discover.com/content/dam/dfs/student-loans/hero/homebanner/home_mob.jpg",
//       bloodGroup: "B+",
//       dob: "29/02/1998",
//       email: "student@std.com",
//       firebaseUuid: "randomid123",
//       isTeacher: false,
//       mobileNo: "1234567890"),
//   User(
//       displayName: "Name2 Surname",
//       division: "B",
//       standard: "6",
//       photoUrl:
//           "https://www.collegechoice.net/wp-content/uploads/2014/07/00_Student.jpg",
//       bloodGroup: "B+",
//       dob: "21/01/2000",
//       email: "student@std.com",
//       firebaseUuid: "randomid1234",
//       isTeacher: false,
//       mobileNo: "1234567450")
// ];
