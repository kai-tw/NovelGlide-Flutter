import '../entities/downloader_task.dart';

abstract class DownloaderRepository {
  Stream<void> get onListChangeStream;

  Future<List<String>> getTaskList();

  Future<DownloaderTask?> getTaskByIdentifier(String identifier);

  Future<String> downloadFile({
    required Uri uri,
    required String name,
  });

  Future<void> cancelTask(String identifier);

  Future<void> removeTask(String identifier);

  Future<void> clearTasks();
}
