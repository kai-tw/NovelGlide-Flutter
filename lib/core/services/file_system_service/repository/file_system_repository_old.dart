part of '../file_system_service.dart';

abstract class FileSystemRepositoryOld {
  const FileSystemRepositoryOld();

  Directory createDirectory(String path) {
    final Directory directory = Directory(path);

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    return directory;
  }

  File createFile(String path) {
    final File file = File(path);

    if (!file.existsSync()) {
      file.createSync();
    }

    return file;
  }
}
