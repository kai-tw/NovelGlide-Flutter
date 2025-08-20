enum MimeType {
  epub(<String>['application/epub+zip']),
  zip(<String>['application/zip']),
  atomFeed(<String>['application/atom+xml']),
  unknown(<String>[]);

  const MimeType(this.tagList);

  factory MimeType.fromString(String typeString) {
    for (MimeType type in values) {
      if (type.tagList.any((String tag) => tag == typeString)) {
        return type;
      }
    }
    return MimeType.unknown;
  }

  final List<String> tagList;
}
