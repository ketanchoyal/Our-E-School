enum AnnouncementType { CIRCULAR, EVENT, ACTIVITY, UNKNOWN }

class AnnouncementTypeHelper {
  static String getValue(AnnouncementType type) {
    switch (type) {
      case AnnouncementType.ACTIVITY:
        return "ACTIVITY";
      case AnnouncementType.CIRCULAR:
        return "CIRCULAR";
      case AnnouncementType.EVENT:
        return "EVENT";
      case AnnouncementType.UNKNOWN:
        return "UNKNOWN";
      default:
        return 'UNKNOWN';
    }
  }

  static AnnouncementType getEnum(String type) {
    switch (type) {
      case "ACTIVITY":
        return AnnouncementType.ACTIVITY;
      case "CIRCULAR":
        return AnnouncementType.CIRCULAR;
      case "EVENT":
        return AnnouncementType.EVENT;
      case "UNKNOWN":
        return AnnouncementType.UNKNOWN;
      default:
        return AnnouncementType.UNKNOWN;
    }
  }
}
