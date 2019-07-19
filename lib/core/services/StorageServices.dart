import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ourESchool/core/services/Services.dart';

class StorageServices extends Services {
  Future<String> setProfilePhoto(String filePath) async {
    if (firebaseUser == null) await getFirebaseUser();
    if (schoolCode == null) await getSchoolCode();
    // String schoolCode = await sharedPreferencesHelper.getSchoolCode();

    String _extension = p.extension(filePath);
    String fileName = firebaseUser.uid + _extension;
    final StorageUploadTask uploadTask =
        storageReference.child(schoolCode + '/' + fileName).putFile(
              File(filePath),
              StorageMetadata(contentType: "image"),
            );

    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    final String profileUrl = await downloadUrl.ref.getDownloadURL();

    await sharedPreferencesHelper.setLoggedInUserPhotoUrl(profileUrl);

    return profileUrl;
  }
}
