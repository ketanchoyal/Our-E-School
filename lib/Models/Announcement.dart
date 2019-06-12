enum AnnouncementType{
CIRCULAR, EVENT, ACTIVITY
}

class Announcements {
  String id;
  String title;
  String timestamp;
  AnnouncementType type;
  String content;
  String caption;
  String photoUrl;
  String forClass;
}