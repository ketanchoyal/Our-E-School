import 'package:cloud_firestore/cloud_firestore.dart';

class User {
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

  User(
      {this.photoUrl = '',
      this.email = '',
      this.division = '',
      this.id = '',
      this.enrollNo = '',
      this.firebaseUuid = '',
      this.displayName = '',
      this.standard = '',
      this.dob = '',
      this.guardianName = '',
      this.bloodGroup = '',
      this.mobileNo = '',
      this.isTeacher = false,
      this.isVerified = false});

  User.fromSnapshot(DocumentSnapshot documentSnapshot)
      : this.firebaseUuid = documentSnapshot["firebaseUuid"].toString() ?? '',
        this.email = documentSnapshot["email"].toString() ?? '',
        this.displayName = documentSnapshot["displayName"].toString() ?? '',
        this.photoUrl = documentSnapshot["photoUrl"].toString() ?? '',
        this.isTeacher = documentSnapshot["isTeacher"] as bool ?? false,
        this.isVerified = documentSnapshot["isVerified"] as bool ?? false,
        this.id = documentSnapshot["id"].toString() ?? '',
        this.dob = documentSnapshot["dob"].toString() ?? '',
        this.division = documentSnapshot["division"].toString() ?? '',
        this.standard = documentSnapshot["standard"].toString() ?? '',
        this.bloodGroup = documentSnapshot["bloodGroup"].toString() ?? '',
        this.guardianName = documentSnapshot["guardianName"].toString() ?? '',
        this.enrollNo = documentSnapshot["enrollNo"].toString(),
        this.mobileNo = documentSnapshot["mobileNo"].toString() ?? '';

  User.fromJson(Map<String, dynamic> json) {
    photoUrl = json['photoUrl'] ?? '';
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoUrl'] = this.photoUrl;
    data['email'] = this.email;
    data['division'] = this.division;
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
    return data;
  }
}

List<User> users = [
  User(
      displayName: "Name Surname",
      division: "A",
      standard: "9",
      photoUrl:
          "https://www.discover.com/content/dam/dfs/student-loans/hero/homebanner/home_mob.jpg",
      bloodGroup: "B+",
      dob: "29/02/1998",
      email: "student@std.com",
      firebaseUuid: "randomid123",
      isTeacher: false,
      mobileNo: "1234567890"),
  User(
      displayName: "Name2 Surname",
      division: "B",
      standard: "6",
      photoUrl:
          "https://www.collegechoice.net/wp-content/uploads/2014/07/00_Student.jpg",
      bloodGroup: "B+",
      dob: "21/01/2000",
      email: "student@std.com",
      firebaseUuid: "randomid1234",
      isTeacher: false,
      mobileNo: "1234567450")
];
