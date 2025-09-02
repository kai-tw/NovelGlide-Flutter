import 'dart:async';
import 'dart:math';

import 'package:path/path.dart';

import '../../../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../../../core/file_system/domain/repositories/temp_repository.dart';
import '../../../../core/log_system/log_system.dart';
import '../../../../core/utils/random_extension.dart';
import '../../domain/entities/downloader_task.dart';
import '../../domain/entities/downloader_task_state.dart';
import '../../domain/repositories/downloader_repository.dart';
import '../data_sources/downloader_transmission_source.dart';

class DownloaderRepositoryImpl implements DownloaderRepository {
  DownloaderRepositoryImpl(
    this._source,
    this._tempRepository,
    this._fileSystemRepository,
  );

  final DownloaderTransmissionSource _source;

  final TempRepository _tempRepository;
  final FileSystemRepository _fileSystemRepository;

  final Map<String, DownloaderTask> _tasks = <String, DownloaderTask>{};

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
  Future<String> downloadFile(Uri uri) async {
    // Create a random identifier
    final Random random = Random();
    String identifier;

    do {
      identifier = random.nextString(10);
    } while (_tasks.containsKey(identifier));

    try {
      final String tempDirectoryPath = await _tempRepository.getDirectoryPath();
      final StreamController<double> progressController =
          StreamController<double>.broadcast();

      // Add task to memory.
      final DownloaderTask task = _tasks[identifier] = DownloaderTask(
        stateCode: DownloaderTaskState.downloading,
        uri: uri,
        savePath:
            join(tempDirectoryPath, uri.pathSegments.lastOrNull ?? identifier),
        onDownloadStream: progressController.stream,
        isManaged: true,
      );

      // Notify a new task was created.
      _onListChangeController.add(null);

      // Download the file.
      _source.downloadFile(identifier, task.uri, task.savePath,
          (double progress) {
        progressController.add(progress);
      }).then((_) {
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

  @override
  Future<void> removeTask(String identifier) async {
    final DownloaderTask? task = _tasks[identifier];
    if (task != null) {
      _tasks.remove(identifier);

      if (task.stateCode == DownloaderTaskState.downloading) {
        await _source.cancelDownload(identifier);
      }

      // Delete the file if it exists.
      if (await _fileSystemRepository.existsFile(task.savePath)) {
        await _fileSystemRepository.deleteFile(task.savePath);
      }

      // Notify a task was removed
      _onListChangeController.add(null);
    }
  }

  @override
  Future<void> clearTasks() async {
    for (final String identifier in _tasks.keys) {
      await removeTask(identifier);

      // Notify all tasks was cleared
      _onListChangeController.add(null);
    }
  }
}
