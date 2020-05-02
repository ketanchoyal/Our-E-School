enum UserType { STUDENT, TEACHER, PARENT, UNKNOWN }

class UserTypeHelper {
  static String getValue(UserType userType) {
    switch (userType) {
      case UserType.PARENT:
        return "PARENT";
      case UserType.STUDENT:
        return "STUDENT";
      case UserType.TEACHER:
        return "TEACHER";
      case UserType.UNKNOWN:
        return "UNKNOWN";
      default:
        return 'UNKNOWN';
    }
  }

  static UserType getEnum(String userType) {
    if (userType == getValue(UserType.PARENT)) {
      return UserType.PARENT;
    } else if (userType == getValue(UserType.STUDENT)) {
      return UserType.STUDENT;
    } else if (userType == getValue(UserType.TEACHER)) {
      return UserType.TEACHER;
    } else {
      return UserType.UNKNOWN;
    }
  }
}
