import 'package:ourESchool/core/services/Services.dart';

class ProfileServices extends Services {
  getFirebaseUser() async {
    firebaseUser = await auth.currentUser();
  }

  ProfileServices() {
    getFirebaseUser();
  }

  setProfileData(
    String displayName,
    String standard,
    String division,
    String bloodGroup,
    String mobileNo,
    String dob,
    String guardianName,
    var photoUrl,
  ) {

  }
}
