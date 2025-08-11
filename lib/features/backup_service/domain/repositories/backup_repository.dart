import 'dart:async';

import '../../../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../../../core/file_system/domain/repositories/temp_repository.dart';

mixin BackupRepository {
  String? tempDirectoryPath;
  Completer<void>? mutexLock;

  TempRepository get tempRepository;

  FileSystemRepository get fileSystemRepository;

  Future<void> startTask() async {
    // Waiting for another progress complete.
    await mutexLock?.future;

    // Initialize a new lock
    mutexLock = Completer<void>();

    // Get a clean temporary directory for working
    tempDirectoryPath = await tempRepository.getDirectoryPath();
  }

  void finishTask() {
    if (tempDirectoryPath != null) {
      fileSystemRepository.deleteDirectory(tempDirectoryPath!);
    }

    // Release the lock
    mutexLock?.complete();
    mutexLock = null;
  }
}
