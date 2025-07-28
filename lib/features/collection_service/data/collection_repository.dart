part of '../collection_service.dart';

class CollectionRepository {
  CollectionRepository();

  final StreamController<void> onChangedController =
      StreamController<void>.broadcast();

  Future<String> get jsonFileName async => (await jsonFile).baseName;

  Future<JsonFileMetaModel> get jsonFile async {
    return FileSystemService.json.getJsonFile(
      await FileSystemService.document.collectionJsonFile,
    );
  }

  /// Create a new empty collection with a unique ID.
  Future<CollectionData> create([String? name]) async {
    // Load json data
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;

    // Create a new id
    String id;

    // Randomly generate a new unique id
    do {
      id = Random().nextString(10);
    } while (jsonData.containsKey(id));

    // Save to json file
    final CollectionData data =
        CollectionData(id, name ?? id, const <String>[]);
    _saveData(data);

    // Send a notification.
    onChangedController.add(null);

    return data;
  }

  Future<CollectionData> getDataById(String id) async {
    // Load json data
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;

    // Return the data, or create a new one if it doesn't exist
    return CollectionData.fromJson(jsonData[id]);
  }

  /// Retrieve a list of all [CollectionData] instances.
  Future<List<CollectionData>> getList() async {
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    return jsonData.keys
        .map((String key) => CollectionData.fromJson(jsonData[key]!))
        .toList();
  }

  /// Save a collection to json file.
  Future<void> _saveData(CollectionData data) async {
    // Load json data
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;

    // Convert the pathList to relative paths.
    for (int i = 0; i < data.pathList.length; i++) {
      data.pathList[i] =
          await BookService.repository.getRelativePath(data.pathList[i]);
    }

    // Remove duplicates.
    data.pathList = data.pathList.toSet().toList();

    // Save the data.
    jsonData[data.id] = data.toJson();
    jsonFile.data = jsonData;
  }

  /// Save a collection to json file.
  Future<void> saveData(Set<CollectionData> dataSet) async {
    for (CollectionData data in dataSet) {
      await _saveData(data);
    }

    // Send a notification.
    onChangedController.add(null);
  }

  /// Delete a collection from json file.
  Future<void> deleteByData(CollectionData data) async {
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;
    jsonData.remove(data.id);
    jsonFile.data = jsonData;

    // Send a notification
    onChangedController.add(null);
  }

  /// Remove a given set of books from a collection.
  /// Return the updated collection data.
  Future<CollectionData> removeBooksFromSingle(
    String id,
    Set<BookData> bookSet,
  ) async {
    // Load json file
    final JsonFileMetaModel jsonFile = await this.jsonFile;

    // Load json data
    final Map<String, dynamic> jsonData = jsonFile.data;

    if (jsonData.containsKey(id)) {
      // Load collection data
      final CollectionData data = CollectionData.fromJson(jsonData[id]!);

      // Remove all the paths in the book set
      for (final BookData book in bookSet) {
        data.pathList.remove(await book.relativeFilePath);
      }

      // Save the collection data
      _saveData(data);
    }

    // Send a notification
    onChangedController.add(null);

    return getDataById(id);
  }

  /// Remove a book from all collections.
  Future<void> removeBookFromAll(String path) async {
    // Get the list of collection data
    final List<CollectionData> list = await getList();

    // Remove the book through each collection
    for (CollectionData data in list) {
      data.pathList.remove(path);
      await _saveData(data);
    }

    // Send a notification
    onChangedController.add(null);
  }

  Future<void> removeAllBooksFromAll() async {
    // Load json file
    final JsonFileMetaModel jsonFile = await this.jsonFile;

    // Load json data
    final Map<String, dynamic> jsonData = jsonFile.data;

    // Remove all the books from all collections
    for (String id in jsonData.keys) {
      final CollectionData data = CollectionData.fromJson(jsonData[id]!);
      data.pathList.clear();
      _saveData(data);
    }
  }

  /// Reset the collection repository.
  Future<void> reset() async {
    // Clear the content of json file
    (await jsonFile).clear();

    // Send a notification
    onChangedController.add(null);
  }
}
