part of '../bookmark_service.dart';

class BookmarkRepositoryOld {
  BookmarkRepositoryOld();

  Future<String> get jsonFileName async => (await jsonFile).baseName;

  Future<JsonFileMetaModel> get jsonFile =>
      FileSystemService.json.bookmarkJsonFile;

  /// Create / Update the bookmark data to the JSON file.
  Future<void> _updateData(Set<BookmarkData> dataSet) async {
    // Load json data
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;

    // Save the data into the JSON file.
    jsonFile.data = jsonData;
  }

  /// Create / Update the bookmark data to the JSON file.
  Future<void> updateData(Set<BookmarkData> dataSet) async {
    await _updateData(dataSet);
  }

  /// Reset the bookmark repository.
  Future<void> reset() async {
    (await jsonFile).clear();
  }
}
