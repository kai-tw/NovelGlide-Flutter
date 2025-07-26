part of '../file_system_service.dart';

class DocumentRepository {
  const DocumentRepository();

  Future<Directory> get rootDirectory => Platform.isIOS
      ? getLibraryDirectory()
      : getApplicationDocumentsDirectory();

  Future<Directory> get libraryDirectory async =>
      Directory(join((await rootDirectory).path, 'Library'));

  /// ==== Data Directories and files ====

  /// Data directory for storing application data.
  Future<Directory> get dataDirectory async =>
      Directory(join((await rootDirectory).path, 'Data'));

  Future<File> get bookmarkJsonFile async =>
      File(join((await dataDirectory).path, 'bookmark.json'));

  Future<File> get collectionJsonFile async =>
      File(join((await dataDirectory).path, 'collection.json'));
}
