import 'dart:io';
import 'dart:typed_data';

abstract class FileSystemRepository {
  Future<Directory> createDirectory(String path);

  Future<File> createFile(String path);

  Future<void> copyFile(String destination, String source);

  Future<bool> existsDirectory(String path);

  Future<bool> existsFile(String path);

  Future<void> writeFileAsBytes(String path, Uint8List bytes);

  Future<Uint8List> readFileAsBytes(String path, {int? start, int? end});

  Stream<Uint8List> streamFileAsBytes(String path, {int? start, int? end});

  Future<void> writeFileAsString(String path, String content);

  Future<String> readFileAsString(String path);

  Future<void> deleteFile(String path);

  Future<void> deleteDirectory(String path);

  Stream<FileSystemEntity> listDirectory(String path);

  Future<int> getFileSize(String path);
}
