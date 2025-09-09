import 'dart:async';
import 'dart:math';

import 'package:path/path.dart';

import '../../../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../../../core/file_system/domain/repositories/temp_repository.dart';
import '../../../../core/lifecycle/domain/repositories/lifecycle_repository.dart';
import '../../../../core/log_system/log_system.dart';
import '../../../../core/utils/random_extension.dart';
import '../../domain/entities/downloader_task.dart';
import '../../domain/entities/downloader_task_state.dart';
import '../../domain/repositories/downloader_repository.dart';
import '../data_sources/downloader_transmission_source.dart';

class DownloaderRepositoryImpl implements DownloaderRepository {
  factory DownloaderRepositoryImpl(
    DownloaderTransmissionSource source,
    TempRepository tempRepository,
    FileSystemRepository fileSystemRepository,
    LifecycleRepository lifecycleRepository,
  ) {
    final DownloaderRepositoryImpl instance = DownloaderRepositoryImpl._(
      source,
      tempRepository,
      fileSystemRepository,
    );

    lifecycleRepository.onDetach.listen(instance.onDetach);

    return instance;
  }

  DownloaderRepositoryImpl._(
    this._source,
    this._tempRepository,
    this._fileSystemRepository,
  );

  final DownloaderTransmissionSource _source;

  final TempRepository _tempRepository;
  final FileSystemRepository _fileSystemRepository;

  final Map<String, DownloaderTask> _tasks = <String, DownloaderTask>{};
  final Map<String, String> _tempDirectoryPaths = <String, String>{};

  final StreamController<void> _onListChangeController =
      StreamController<void>.broadcast();

  @override
  Stream<void> get onListChangeStream => _onListChangeController.stream;

  @override
  Future<List<String>> getTaskList() async {
    return _tasks.keys.toList();
  }

  @override
  Future<DownloaderTask?> getTaskByIdentifier(String identifier) async {
    return _tasks[identifier];
  }

  @override
  Future<String> downloadFile({
    required Uri uri,
    required String name,
  }) async {
    // Create a random identifier
    final Random random = Random();
    String identifier;

    do {
      identifier = random.nextString(10);
    } while (_tasks.containsKey(identifier));

    try {
      final String tempDirectoryPath = await _tempRepository.getDirectoryPath();
      _tempDirectoryPaths[identifier] = tempDirectoryPath;

      final StreamController<double> progressController =
          StreamController<double>.broadcast();

      // Add task to memory.
      final DownloaderTask task = _tasks[identifier] = DownloaderTask(
        stateCode: DownloaderTaskState.downloading,
        name: name,
        uri: uri,
        savePath:
            join(tempDirectoryPath, uri.pathSegments.lastOrNull ?? identifier),
        onDownloadStream: progressController.stream,
        startTime: DateTime.now(),
      );

      // Notify a new task was created.
      _onListChangeController.add(null);

      // Download the file.
      _source.downloadFile(
        identifier,
        task.uri,
        task.savePath,
        (double progress) {
          progressController.add(progress);
        },
      ).then((_) {
        // Download file completed.
        progressController.close();

        if (_tasks.containsKey(identifier)) {
          _tasks[identifier] = _tasks[identifier]!.copyWith(
            stateCode: DownloaderTaskState.success,
          );
        }
      }).catchError((dynamic error) {
        // Download file failed.
        progressController.addError(error);
        progressController.close();

        if (_tasks.containsKey(identifier)) {
          _tasks[identifier] = _tasks[identifier]!.copyWith(
            stateCode: DownloaderTaskState.error,
          );
        }
      });
    } catch (e, s) {
      LogSystem.error(
        'An error occurred during the download task creation.',
        error: e,
        stackTrace: s,
      );

      if (_tasks.containsKey(identifier)) {
        _tasks[identifier] = _tasks[identifier]!.copyWith(
          stateCode: DownloaderTaskState.error,
        );
      }
    }

    return identifier;
  }

  Future<void> _deleteSavedFile(String identifier) async {
    final DownloaderTask? task = _tasks[identifier];
    if (task != null) {
      final String path = task.savePath;

      if (await _fileSystemRepository.existsFile(path)) {
        await _fileSystemRepository.deleteFile(path);
      }
    }
  }

  Future<void> _deleteTempDirectory(String identifier) async {
    final String? path = _tempDirectoryPaths[identifier];
    if (path != null) {
      // Remove from map.
      _tempDirectoryPaths.remove(identifier);

      // Check if the directory is exists.
      if (await _fileSystemRepository.existsDirectory(path)) {
        // Delete it.
        await _fileSystemRepository.deleteDirectory(path);
      }
    }
  }

  @override
  Future<void> removeTask(String identifier) async {
    if (_tasks.containsKey(identifier)) {
      await _removeTask(identifier);

      // Notify a task was removed
      _onListChangeController.add(null);
    }
  }

  /// The function of removing task from the repository.
  /// It will not notify listeners.
  Future<void> _removeTask(String identifier) async {
    if (_tasks.containsKey(identifier)) {
      await cancelTask(identifier);

      // Delete the temporary directory.
      await _deleteTempDirectory(identifier);

      // Remove from memory.
      _tasks.remove(identifier);
    }
  }

  @override
  Future<void> cancelTask(String identifier) async {
    final DownloaderTask? task = _tasks[identifier];
    if (task != null) {
      if (task.stateCode case DownloaderTaskState.downloading) {
        // Cancel the download.
        await _source.cancelDownload(identifier);

        _tasks[identifier] = task.copyWith(
          stateCode: DownloaderTaskState.canceled,
        );
      }

      // Delete the saved file.
      await _deleteSavedFile(identifier);
    }
  }

  @override
  Future<void> clearTasks() async {
    bool isChanged = false;
    int i = 0;
    while (i < _tasks.length) {
      final String identifier = _tasks.keys.elementAt(i);
      final DownloaderTask task = _tasks[identifier]!;

      // Only clear all successful tasks.
      if (task.stateCode case DownloaderTaskState.success) {
        await _removeTask(identifier);

        isChanged = true;
      } else {
        i++;
      }
    }

    if (isChanged) {
      // Notify all tasks was cleared
      _onListChangeController.add(null);
    }
  }

  Future<void> onDetach(void _) async {
    while (_tasks.isNotEmpty) {
      await _removeTask(_tasks.keys.first);
    }
  }
}
