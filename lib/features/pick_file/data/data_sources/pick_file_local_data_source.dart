abstract class PickFileLocalDataSource {
  Future<Set<String>> pickFiles({
    required List<String> allowedExtensions,
  });

  Future<void> clearTemporaryFiles();
}
