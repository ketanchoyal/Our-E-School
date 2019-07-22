import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/services/AnnouncementServices.dart';
import 'package:ourESchool/core/viewmodel/BaseModel.dart';
import 'package:ourESchool/locator.dart';

class AnnouncementPageModel extends BaseModel {
  AnnouncementServices _announcementServices = locator<AnnouncementServices>();

  AnnouncementPageModel() {}

  List<DocumentSnapshot> get postSnapshotList =>
      _announcementServices.postDocumentSnapshots;

  getAnnouncements(String stdDiv_Global, var scaffoldKey) async {
    setState(ViewState.Busy);
    await _announcementServices.getAnnouncements(stdDiv_Global, scaffoldKey);
    setState(ViewState.Idle);
  }

  onRefresh(String stdDiv_Global, var scaffoldKey) async {
    _announcementServices.postDocumentSnapshots.clear();
    _announcementServices.lastPostSnapshot = null;
    await getAnnouncements(stdDiv_Global, scaffoldKey);
  }
}
