enum MimeType {
  epub(
    <String>['application/epub+zip'],
    <String>['epub'],
  ),
  zip(<String>['application/zip'], <String>['zip']),
  atomFeed(
    <String>['application/atom+xml'],
    <String>[],
  ),
  unknown(
    <String>[],
    <String>[],
  );

  const MimeType(this.tagList, this.extensionList);

  factory MimeType.fromString(String typeString) {
    for (MimeType type in values) {
      if (type.tagList.any((String tag) => tag == typeString)) {
        return type;
      }
    }
    return MimeType.unknown;
  }

  final List<String> tagList;
  final List<String> extensionList;
}
