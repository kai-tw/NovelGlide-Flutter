part of '../file_system_service.dart';

class JsonRepository extends FileSystemRepository {
  const JsonRepository();

  Future<Directory> get rootDirectory =>
      FileSystemService.document.dataDirectory;

  Future<JsonFileMetaModel> get bookmarkJsonFile async {
    final String path = join((await rootDirectory).path, 'bookmark.json');
    final File file = createFile(path);
    return getJsonFile(file);
  }

  Future<JsonFileMetaModel> get collectionJsonFile async {
    final String path = join((await rootDirectory).path, 'collection.json');
    final File file = createFile(path);
    return getJsonFile(file);
  }

  JsonFileMetaModel getJsonFile(File file, {String fallbackValue = '{}'}) {
    return JsonFileMetaModel(
      file: file,
      fallbackValue: fallbackValue,
    );
  }
}
