import 'dart:io';
import 'dart:typed_data';

abstract class FileSystemRepository {
  Future<Directory> createDirectory(String path);

  Future<File> createFile(String path);

  Future<void> copyFile(String destination, String source);

  Future<bool> existsDirectory(String path);

  Future<bool> existsFile(String path);

  Future<void> writeFileAsBytes(String path, Uint8List bytes);

  Future<Uint8List> readFileAsBytes(String path);

  Future<void> deleteFile(String path);
}
