part of '../file_system_service.dart';

class TempRepository extends FileSystemRepository {
  const TempRepository();

  Future<Directory> get rootDirectory => getTemporaryDirectory();

  Future<Directory> getDirectory() async {
    final Directory root = await rootDirectory;
    Directory tempFolder;

    do {
      tempFolder = Directory(join(root.path, Random().nextString(8)));
    } while (tempFolder.existsSync());

    tempFolder.createSync(recursive: true);
    return tempFolder;
  }
}
