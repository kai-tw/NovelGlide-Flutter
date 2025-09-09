import '../../domain/entities/bookmark_data.dart';

mixin BookmarkJsonParser {
  /// Encode BookmarkData to json data
  Map<String, dynamic> encodeBookmarkJson(BookmarkData data) {
    return <String, dynamic>{
      // Change version if the data structure is changed.
      'version': 2,
      'bookIdentifier': data.bookIdentifier,
      'bookName': data.bookName,
      'chapterTitle': data.chapterTitle,
      'chapterIdentifier': data.chapterIdentifier,
      'startCfi': data.startCfi,
      'savedTime': data.savedTime.toIso8601String(),
    };
  }

  /// Decode json data to BookmarkData
  BookmarkData decodeBookmarkJson(Map<String, dynamic> json) {
    final int? version = json['version'];

    switch (version) {
      case 2:
        return BookmarkData(
          bookIdentifier: json['bookIdentifier'],
          bookName: json['bookName'],
          chapterTitle: json['chapterTitle'],
          chapterIdentifier: json['chapterIdentifier'],
          startCfi: json['startCfi'],
          savedTime: DateTime.parse(json['savedTime']),
        );

      default:
        return BookmarkData(
          bookIdentifier: json['bookPath'],
          bookName: json['bookName'],
          chapterTitle: json['chapterTitle'],
          chapterIdentifier: json['chapterFileName'],
          startCfi: json['startCfi'],
          savedTime: DateTime.parse(json['savedTime']),
        );
    }
  }
}
