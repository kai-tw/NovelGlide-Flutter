abstract class PickBookDataSource {
  Future<Set<String>> pickFiles({
    required List<String> allowedExtensions,
    required Set<String> selectedFileName,
  });

  Future<void> clearTemporaryFiles();
}
