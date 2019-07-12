import "package:cloud_firestore/cloud_firestore.dart";

class User {
  final String firebaseUuid;
  final String email;
  // final String registeredMobileNo;
  final String photoUrl;
  final String displayName;
  final bool isTeacher;
  final bool isVerified;
  final String id;
  final String standard;
  final String division;
  final String bloodGroup;
  final String mobileNo;
  final String guardianName;
  final String dob;
  final String enrollNo;

  // User.initial()
  //     : this.firebaseUuid = "",
  //       this.email = "",
  //       this.displayName = "",
  //       this.photoUrl = "",
  //       this.isTeacher = false,
  //       this.isVerified = false,
  //       this.id = "",
  //       this.dob = "",
  //       this.division = "",
  //       this.standard = "",
  //       this.bloodGroup = "",
  //       this.mobileNo = "";

  User({
    this.firebaseUuid = "",
    this.email = "",
    this.displayName = "",
    this.photoUrl = "",
    this.isTeacher = false,
    this.isVerified = false,
    this.id = "",
    this.dob = "",
    this.division = "",
    this.standard = "",
    this.bloodGroup = "",
    this.mobileNo = "",
    this.guardianName = "",
    this.enrollNo = "",
    // this.registeredMobileNo,
  });

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

  @override
  String toString() {
    return "$email - $displayName - $photoUrl - $mobileNo - $isVerified";
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
