import 'dart:async';

import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/backup_progress_data.dart';
import '../entities/backup_progress_step_code.dart';
import '../repositories/bookmark_backup_repository.dart';

class BackupBookmarkCreateUseCase
    extends UseCase<Stream<BackupProgressData>, void> {
  BackupBookmarkCreateUseCase(this._repository);

  final BookmarkBackupRepository _repository;

  final StreamController<BackupProgressData> _controller =
      StreamController<BackupProgressData>();

  @override
  Stream<BackupProgressData> call([void parameter]) {
    _runner();
    return _controller.stream;
  }

  Future<void> _runner() async {
    // Start the uploading process
    _controller.add(const BackupProgressData(
      step: BackupProgressStepCode.upload,
    ));

    // Upload the file to cloud
    final bool result = await _repository.uploadToCloud((double progress) {
      _controller.add(BackupProgressData(
        step: BackupProgressStepCode.upload,
        progress: progress,
      ));
    });

    _controller.add(BackupProgressData(
      step: result ? BackupProgressStepCode.done : BackupProgressStepCode.error,
    ));

    _controller.close();
  }
}
