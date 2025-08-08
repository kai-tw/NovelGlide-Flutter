abstract class ReaderServerRepository {
  Future<Uri> start(String bookFilePath);
  Future<void> stop();
}
