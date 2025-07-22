part of '../bookmark_service.dart';

class BookmarkRepository {
  BookmarkRepository();

  String jsonFileName = 'bookmark.json';

  Future<File> get jsonFile async {
    final File file = await FileSystemDomain.document.bookmarkJsonFile;
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  /// JSON data getter
  Future<Map<String, dynamic>> get jsonData async {
    String jsonString = (await jsonFile).readAsStringSync();
    jsonString = jsonString.isEmpty ? '{}' : jsonString;
    try {
      (await jsonFile).writeAsStringSync(jsonString);
      return jsonDecode(jsonString);
    } catch (e) {
      reset();
      return <String, dynamic>{};
    }
  }

  /// Retrieve a bookmark by its book path.
  Future<BookmarkData?> get(String bookPath) async {
    final Map<String, dynamic> jsonData = await this.jsonData;
    bookPath = BookService.repository.getRelativePath(bookPath);
    return jsonData.containsKey(bookPath) ? BookmarkData.fromJson(jsonData[bookPath]!) : null;
  }

  /// Retrieve a list of all bookmarks.
  Future<List<BookmarkData>> getList() async {
    final Map<String, dynamic> jsonData = await this.jsonData;
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
    final File jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = await this.jsonData;
    final BookmarkData savedData = data.copyWith(
      bookPath: BookService.repository.getRelativePath(data.bookPath),
      savedTime: DateTime.now(),
    );
    jsonData[savedData.bookPath] = savedData.toJson();
    jsonFile.writeAsStringSync(jsonEncode(jsonData));
  }

  /// Delete the current bookmark from the JSON file.
  Future<void> delete(BookmarkData data) async {
    final File jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = await this.jsonData;
    final String path = BookService.repository.getRelativePath(data.bookPath);
    jsonData.remove(path);
    jsonFile.writeAsStringSync(jsonEncode(jsonData));
  }

  /// Delete the bookmark by path.
  Future<void> deleteByPath(String path) async {
    final List<BookmarkData> list = await getList();
    list
        .where((BookmarkData e) =>
            BookService.repository.getRelativePath(e.bookPath) == BookService.repository.getRelativePath(path))
        .forEach(delete);
  }

  /// Reset the bookmark repository.
  Future<void> reset() async {
    final File jsonFile = await this.jsonFile;
    jsonFile.writeAsStringSync('{}');
  }
}
