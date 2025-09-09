abstract class ReaderLocationCacheRepository {
  Future<void> store(String bookIdentifier, String location);

  Future<String?> get(String bookIdentifier);

  Future<void> delete(Set<String> bookIdentifierSet);

  Future<void> clear();
}
