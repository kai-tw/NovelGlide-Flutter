part of '../../backup_service.dart';

abstract class BackupRepository {
  abstract final String archiveName;
  Directory? tempDirectory;
  Completer<void>? mutexLock;

  Future<String?> get googleDriveFileId =>
      GoogleApiInterfaces.drive.getFileId(archiveName);

  Future<void> startTask() async {
    // Waiting for another progress complete.
    await mutexLock?.future;

    // Initialize a new lock
    mutexLock = Completer<void>();

    // Get a clean temporary directory for working
    tempDirectory = await FileSystemService.temp.getDirectory();
  }

  void finishTask() {
    tempDirectory?.deleteSync(recursive: true);

    // Release the lock
    mutexLock?.complete();
    mutexLock = null;
  }
}
