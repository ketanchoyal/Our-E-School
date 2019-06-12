enum AnnouncementType{
CIRCULAR, EVENT, ACTIVITY
}

class Announcement {
  String by;
  String id;
  // String title;
  String timestamp;
  AnnouncementType type;
  // String content;
  String caption;
  String photoUrl;
  String forClass;

  Announcement({this.by, this.caption, this.forClass, this.id, this.photoUrl, this.timestamp, this.type});
}