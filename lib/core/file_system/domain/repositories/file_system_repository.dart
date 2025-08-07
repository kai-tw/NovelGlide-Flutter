import 'dart:io';

abstract class FileSystemRepository {
  Future<Directory> createDirectory(String path);
  Future<File> createFile(String path);

  Future<bool> existsDirectory(String path);
  Future<bool> existsFile(String path);

  Future<void> writeFileAsBytes(String path, List<int> bytes);
  Future<List<int>> readFileAsBytes(String path);

  Future<void> deleteFile(String path);
}
