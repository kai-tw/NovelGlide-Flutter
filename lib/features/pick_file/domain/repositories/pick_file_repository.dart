abstract class PickFileRepository {
  Future<Set<String>> pickFiles({
    required List<String> allowedExtensions,
  });

  Future<void> clearTemporaryFiles();
}
