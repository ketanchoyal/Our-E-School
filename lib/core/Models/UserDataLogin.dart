class UserDataLogin {
  String id;
  String email;
  bool isATeacher;
  List<dynamic> childIds;

  UserDataLogin({this.id, this.email, this.isATeacher = false, this.childIds});
}
