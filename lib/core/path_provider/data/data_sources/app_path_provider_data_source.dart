abstract class AppPathProviderDataSource {
  Future<String> get documentPath;
  Future<String> get cachePath;
  Future<String> get tempPath;
}
