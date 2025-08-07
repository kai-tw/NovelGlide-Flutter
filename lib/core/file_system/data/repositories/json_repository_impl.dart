import 'dart:convert';

import '../../domain/repositories/file_system_repository.dart';
import '../../domain/repositories/json_repository.dart';

/// A concrete implementation of the JsonRepository.
/// This class uses the FileSystemRepository to handle file operations
/// and the dart:convert library to handle JSON encoding/decoding.
class JsonRepositoryImpl implements JsonRepository {
  const JsonRepositoryImpl(this._fileSystemRepository);

  final FileSystemRepository _fileSystemRepository;

  @override
  Future<Map<String, dynamic>> readJson({
    required String path,
    String fallbackValue = '{}',
  }) async {
    try {
      final List<int> fileBytes =
          await _fileSystemRepository.readFileAsBytes(path);
      final String jsonString = utf8.decode(fileBytes);
      return jsonString.isEmpty
          ? jsonDecode(fallbackValue)
          : jsonDecode(jsonString);
    } catch (e) {
      // If the file doesn't exist, has invalid content, or another error occurs,
      // create a new file with the fallback value and return an empty map.
      await _fileSystemRepository.writeFileAsBytes(
          path, utf8.encode(fallbackValue));
      return jsonDecode(fallbackValue);
    }
  }

  @override
  Future<void> writeJson({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final String jsonString = jsonEncode(data);
    final List<int> fileBytes = utf8.encode(jsonString);
    await _fileSystemRepository.writeFileAsBytes(path, fileBytes);
  }
}
