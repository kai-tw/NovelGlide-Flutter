part of '../bookmark_service.dart';

class BookmarkRepository {
  BookmarkRepository();

  Future<String> get jsonFileName async => (await jsonFile).baseName;

  Future<JsonFileMetaModel> get jsonFile async {
    return FileSystemService.json.getJsonFile(
      await FileSystemService.document.bookmarkJsonFile,
    );
  }

  final StreamController<void> onChangedController =
      StreamController<void>.broadcast();

  /// Retrieve a bookmark by its book path.
  Future<BookmarkData?> get(String bookPath) async {
    // Load json data
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;

    // Use relative path.
    bookPath = await BookService.repository.getRelativePath(bookPath);

    return jsonData.containsKey(bookPath)
        ? BookmarkData.fromJson(jsonData[bookPath])
        : null;
  }

  /// Retrieve a list of all bookmarks.
  Future<List<BookmarkData>> getList() async {
    // Load json data
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;

    final List<BookmarkData> retList = <BookmarkData>[];

    for (String key in jsonData.keys) {
      final BookmarkData data = BookmarkData.fromJson(jsonData[key]!);

      if (await BookService.repository.exists(data.bookPath)) {
        retList.add(data);
      } else {
        deleteData(data);
      }
    }

    return retList;
  }

  /// Save the current bookmark to the JSON file.
  Future<void> _saveData(BookmarkData data) async {
    // Load json data
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;

    final BookmarkData savedData = data.copyWith(
      bookPath: await BookService.repository.getRelativePath(data.bookPath),
      savedTime: DateTime.now(),
    );
    jsonData[savedData.bookPath] = savedData.toJson();
    jsonFile.data = jsonData;
  }

  /// Save the current bookmark to the JSON file.
  Future<void> saveData(BookmarkData data) async {
    await _saveData(data);

    // Send a notification.
    onChangedController.add(null);
  }

  /// Delete the current bookmark from the JSON file.
  Future<void> _deleteData(BookmarkData data) async {
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    final String path =
        await BookService.repository.getRelativePath(data.bookPath);
    jsonData.remove(path);
    jsonFile.data = jsonData;
  }

  /// Delete the current bookmark from the JSON file.
  Future<void> deleteData(BookmarkData data) async {
    await _deleteData(data);

    // Send a notification
    onChangedController.add(null);
  }

  /// Delete the bookmark by path.
  Future<void> deleteByPath(String path) async {
    final List<BookmarkData> list = await getList();

    for (BookmarkData data in list) {
      if (await BookService.repository.getRelativePath(data.bookPath) ==
          await BookService.repository.getRelativePath(path)) {
        await deleteData(data);
      }
    }

    // Send a notification
    onChangedController.add(null);
  }

  /// Reset the bookmark repository.
  Future<void> reset() async {
    (await jsonFile).clear();

    // Send a notification
    onChangedController.add(null);
  }
}
