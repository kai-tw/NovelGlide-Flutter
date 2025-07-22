part of '../file_system_domain.dart';

class DocumentDirectory {
  DocumentDirectory();

  Future<Directory> get rootDirectory => getApplicationDocumentsDirectory();

  Future<Directory> get bookshelfDirectory async =>
      Directory(join((await rootDirectory).path, 'Library'));

  /// ==== Data Directories and files ====

  /// Data directory for storing application data.
  Future<Directory> get dataDirectory async =>
      Directory(join((await rootDirectory).path, 'Data'));

  Future<File> get bookmarkJsonFile async =>
      File(join((await dataDirectory).path, 'bookmark.json'));
}
