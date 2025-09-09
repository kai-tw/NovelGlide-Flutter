abstract class AppPathProvider {
  /// The root directory for user documents.
  Future<String> get documentPath;
  Future<String> get dataPath;
  Future<String> get libraryPath;

  /// The root directory for temporary cache files.
  Future<String> get cachePath;
  Future<String> get bookLocationCachePath;

  /// The root directory for temporary files.
  Future<String> get tempPath;
}
