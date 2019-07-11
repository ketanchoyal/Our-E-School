enum UserType { STUDENT, TEACHER, PARENT }

class UserTypeHelper {
  static String getValue(UserType userType) {
    switch (userType) {
      case UserType.PARENT:
        return "PARENT";
      case UserType.STUDENT:
        return "STUDENT";
      case UserType.TEACHER:
        return "TEACHER";
      default:
        return 'UNKNOWN';
    }
  }

  static UserType getEnum(String userType) {
    if (userType == getValue(UserType.PARENT)) {
      return UserType.PARENT;
    } else if (userType == getValue(UserType.STUDENT)) {
      return UserType.STUDENT;
    } else {
      return UserType.TEACHER;
    }
  }
}
