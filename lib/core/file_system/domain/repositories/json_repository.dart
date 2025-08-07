abstract class JsonRepository {
  /// Reads a JSON file from the given path and returns the decoded data.
  ///
  /// The [fallbackValue] is used to create a new file if one does not exist,
  /// or if the file content is empty or invalid.
  Future<Map<String, dynamic>> readJson({
    required String path,
    String fallbackValue = '{}',
  });

  /// Writes the given JSON data to a file at the specified path.
  Future<void> writeJson({
    required String path,
    required Map<String, dynamic> data,
  });
}
