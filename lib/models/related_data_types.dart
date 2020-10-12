enum RelatedDataTypes { COMICS, EVENTS, SERIES, STORIES }

class RelatedDataTypesHelper {
  static String getValue(RelatedDataTypes type) {
    switch (type) {
      case RelatedDataTypes.COMICS:
        return "comics";
      case RelatedDataTypes.EVENTS:
        return "events";
      case RelatedDataTypes.SERIES:
        return "series";
      case RelatedDataTypes.STORIES:
        return "stories";
      default:
        return "";
    }
  }
}
