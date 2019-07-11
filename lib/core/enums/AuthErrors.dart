enum AuthErrors {
  UserNotFound,
  PasswordNotValid,
  NetworkError,
  SUCCESS,
  UNKNOWN
}

class AuthErrorsHelper {
  static String getValue(AuthErrors authError) {
    switch (authError) {
      case AuthErrors.UserNotFound:
        return "No such User Found";
      case AuthErrors.PasswordNotValid:
        return "Password is not valid";
      case AuthErrors.NetworkError:
        return "A network error has occurred, please try again";
      case AuthErrors.SUCCESS:
        return "Task performed succesfully";
      case AuthErrors.UNKNOWN:
        return "Something went wrong!";
      default:
        return "opps, please Try again";
    }
  }
}
