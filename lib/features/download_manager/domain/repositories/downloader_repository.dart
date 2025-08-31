import '../entities/downloader_task.dart';

abstract class DownloaderRepository {
  Future<List<String>> getTaskList();

  Future<DownloaderTask?> getTaskByIdentifier(String identifier);

  Future<String> downloadFile(Uri uri);

  Future<void> removeTask(String identifier);

  Future<void> clearTasks();
}
