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

  /// Create / Update the bookmark data to the JSON file.
  Future<void> _updateData(Set<BookmarkData> dataSet) async {
    // Load json data
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;

    for (BookmarkData data in dataSet) {
      // Save the data into the JSON data
      final BookmarkData savedData = data.copyWith(
        bookPath: await BookService.repository.getRelativePath(data.bookPath),
      );

      jsonData[savedData.bookPath] = savedData.toJson();
    }

    // Save the data into the JSON file.
    jsonFile.data = jsonData;
  }

  /// Create / Update the bookmark data to the JSON file.
  Future<void> updateData(Set<BookmarkData> dataSet) async {
    await _updateData(dataSet);

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
        await _deleteData(data);
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
