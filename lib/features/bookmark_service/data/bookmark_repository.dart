part of '../bookmark_service.dart';

class BookmarkRepository {
  BookmarkRepository();

  String jsonFileName = 'bookmark.json';

  String get jsonPath => join(FilePath.dataRoot, jsonFileName);

  File get jsonFile {
    final File file = File(jsonPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  /// JSON data getter
  Map<String, dynamic> get jsonData => JsonUtils.fromFile(jsonFile);

  /// JSON data setter
  set jsonData(Map<String, dynamic> json) =>
      jsonFile.writeAsStringSync(jsonEncode(json));

  /// Retrieve a bookmark by its book_service path.
  BookmarkData? get(String bookPath) {
    bookPath = BookService.repository.getRelativePath(bookPath);
    return jsonData.containsKey(bookPath)
        ? BookmarkData.fromJson(jsonData[bookPath]!)
        : null;
  }

  /// Retrieve a list of all bookmarks.
  List<BookmarkData> getList() {
    final List<BookmarkData> retList = <BookmarkData>[];

    for (String key in jsonData.keys) {
      final BookmarkData data = BookmarkData.fromJson(jsonData[key]!);
      final String path = BookService.repository.getAbsolutePath(data.bookPath);

      if (File(path).existsSync()) {
        retList.add(data);
      } else {
        delete(data);
      }
    }

    return retList;
  }

  /// Save the current bookmark to the JSON file.
  Future<void> save(BookmarkData data) async {
    final Map<String, dynamic> json = jsonData;
    final BookmarkData savedData = data.copyWith(
      bookPath: BookService.repository.getRelativePath(data.bookPath),
      savedTime: DateTime.now(),
    );
    json[savedData.bookPath] = savedData.toJson();
    jsonData = json;
  }

  /// Delete the current bookmark from the JSON file.
  void delete(BookmarkData data) {
    final Map<String, dynamic> json = jsonData;
    final String path = BookService.repository.getRelativePath(data.bookPath);
    json.remove(path);
    jsonData = json;
  }

  /// Delete the bookmark by path.
  void deleteByPath(String path) {
    getList()
        .where((BookmarkData e) =>
            BookService.repository.getRelativePath(e.bookPath) ==
            BookService.repository.getRelativePath(path))
        .forEach(delete);
  }

  /// Reset the bookmark repository.
  void reset() => jsonData = <String, dynamic>{};
}
