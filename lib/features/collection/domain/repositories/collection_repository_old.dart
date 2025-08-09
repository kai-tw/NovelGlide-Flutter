part of '../../collection_service.dart';

class CollectionRepositoryOld {
  CollectionRepositoryOld();

  Future<String> get jsonFileName async => (await jsonFile).baseName;

  Future<JsonFileMetaModel> get jsonFile =>
      FileSystemService.json.collectionJsonFile;

  /// Save a collection to json file.
  Future<void> _updateData(CollectionData data) async {
    // Load json data
    final JsonFileMetaModel jsonFile = await this.jsonFile;
    final Map<String, dynamic> jsonData = jsonFile.data;

    // Convert the pathList to relative paths.
    for (int i = 0; i < data.pathList.length; i++) {
      data.pathList[i] =
          await BookService.repository.getRelativePath(data.pathList[i]);
    }

    // Remove duplicates.
    data = data.copyWith(pathList: data.pathList.toSet().toList());

    // Save the data.
    jsonData[data.id] = data.toJson();
    jsonFile.data = jsonData;
  }

  /// Save a collection to json file.
  Future<void> updateData(Set<CollectionData> dataSet) async {
    for (CollectionData data in dataSet) {
      await _updateData(data);
    }
  }

  /// Reset the collection repository.
  Future<void> reset() async {
    // Clear the content of json file
    (await jsonFile).clear();
  }
}
