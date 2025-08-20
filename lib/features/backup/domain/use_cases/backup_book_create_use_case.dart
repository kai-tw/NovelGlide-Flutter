import 'dart:async';

import '../../../../core/domain/use_cases/use_case.dart';
import '../../../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../../../core/file_system/domain/repositories/temp_repository.dart';
import '../entities/backup_progress_data.dart';
import '../entities/backup_progress_step_code.dart';
import '../repositories/book_backup_repository.dart';

class BackupBookCreateUseCase
    extends UseCase<Stream<BackupProgressData>, void> {
  BackupBookCreateUseCase(
    this._fileSystemRepository,
    this._tempRepository,
    this._bookBackupRepository,
  );

  final FileSystemRepository _fileSystemRepository;
  final TempRepository _tempRepository;
  final BookBackupRepository _bookBackupRepository;

  final StreamController<BackupProgressData> _controller =
      StreamController<BackupProgressData>();

  @override
  Stream<BackupProgressData> call([void parameter]) {
    _runner();
    return _controller.stream;
  }

  Future<void> _runner() async {
    // Create library backup task
    _controller
        .add(const BackupProgressData(step: BackupProgressStepCode.create));

    // Get a temporary working directory
    final String tempDirectoryPath = await _tempRepository.getDirectoryPath();
    await _fileSystemRepository.createDirectory(tempDirectoryPath);

    // Start zipping task
    _controller.add(const BackupProgressData(step: BackupProgressStepCode.zip));

    // Create the zip file
    final String zipFilePath = await _bookBackupRepository
        .archive(tempDirectoryPath, (double progress) {
      _controller.add(BackupProgressData(
        step: BackupProgressStepCode.zip,
        progress: progress,
      ));
    });

    // Upload the zip file
    _controller
        .add(const BackupProgressData(step: BackupProgressStepCode.upload));

    // Upload the zip file to cloud
    final bool isSuccessful = await _bookBackupRepository
        .uploadToCloud(zipFilePath, (double progress) {
      _controller.add(BackupProgressData(
        step: BackupProgressStepCode.upload,
        progress: progress,
      ));
    });

    if (isSuccessful) {
      _controller
          .add(const BackupProgressData(step: BackupProgressStepCode.done));
    } else {
      _controller
          .add(const BackupProgressData(step: BackupProgressStepCode.error));
    }

    // Finish the task
    _fileSystemRepository.deleteDirectory(tempDirectoryPath);
    _controller.close();
  }
}
