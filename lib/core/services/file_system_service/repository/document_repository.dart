part of '../file_system_service.dart';

class DocumentRepository extends FileSystemRepositoryOld {
  const DocumentRepository();

  Future<Directory> get rootDirectory => Platform.isIOS
      ? getLibraryDirectory()
      : getApplicationDocumentsDirectory();

  /// Library directory for storing all books.
  Future<Directory> get libraryDirectory async =>
      createDirectory(join((await rootDirectory).path, 'Library'));

  /// Data directory for storing application data.
  Future<Directory> get dataDirectory async =>
      createDirectory(join((await rootDirectory).path, 'Data'));
}
