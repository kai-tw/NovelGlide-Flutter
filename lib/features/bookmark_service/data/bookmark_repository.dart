part of '../bookmark_service.dart';

class BookmarkRepository {
  BookmarkRepository();

  Future<String> get jsonFileName async => (await jsonFile).baseName;

  Future<JsonFileModel> get jsonFile async {
    return FileSystemService.json.getJsonFile(
      await FileSystemService.document.bookmarkJsonFile,
    );
  }

  /// Retrieve a bookmark by its book path.
  Future<BookmarkData?> get(String bookPath) async {
    final JsonFileModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    bookPath = await BookService.repository.getRelativePath(bookPath);
    return jsonData.containsKey(bookPath)
        ? BookmarkData.fromJson(jsonData[bookPath]!)
        : null;
  }

  /// Retrieve a list of all bookmarks.
  Future<List<BookmarkData>> getList() async {
    final JsonFileModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    final List<BookmarkData> retList = <BookmarkData>[];

    for (String key in jsonData.keys) {
      final BookmarkData data = BookmarkData.fromJson(jsonData[key]!);

      if (await BookService.repository.exists(data.bookPath)) {
        retList.add(data);
      } else {
        delete(data);
      }
    }

    return retList;
  }

  /// Save the current bookmark to the JSON file.
  Future<void> save(BookmarkData data) async {
    final JsonFileModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    final BookmarkData savedData = data.copyWith(
      bookPath: await BookService.repository.getRelativePath(data.bookPath),
      savedTime: DateTime.now(),
    );
    jsonData[savedData.bookPath] = savedData.toJson();
    jsonFile.data = jsonData;
  }

  /// Delete the current bookmark from the JSON file.
  Future<void> delete(BookmarkData data) async {
    final JsonFileModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    final String path =
        await BookService.repository.getRelativePath(data.bookPath);
    jsonData.remove(path);
    jsonFile.data = jsonData;
  }

  /// Delete the bookmark by path.
  Future<void> deleteByPath(String path) async {
    final List<BookmarkData> list = await getList();
    list
        .where((BookmarkData e) =>
            BookService.repository.getRelativePath(e.bookPath) ==
            BookService.repository.getRelativePath(path))
        .forEach(delete);
  }

  /// Reset the bookmark repository.
  Future<void> reset() async {
    (await jsonFile).clear();
  }
}
