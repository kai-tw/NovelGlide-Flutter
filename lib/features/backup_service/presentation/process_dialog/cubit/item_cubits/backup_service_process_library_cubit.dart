part of '../../../../backup_service.dart';

class BackupServiceProcessLibraryCubit extends BackupServiceProcessItemCubit {
  BackupServiceProcessLibraryCubit({super.googleDriveFileId});

  @override
  final BackupTargetType _targetType = BackupTargetType.library;

  /// Backup the library.
  @override
  Future<void> _create() async {
    // Start backup
    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.create,
    ));

    // Start the task!
    await BackupService.bookRepository.startTask();

    // Start zipping
    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.zip,
    ));

    // Zip the library
    final File zipFile = await BackupService.bookRepository.archive(
      onZipping: (double progress) {
        emit(BackupServiceProcessItemState(
          step: BackupProgressStepCode.zip,
          progress: progress / 100,
        ));
      },
    );

    // Upload the zip file
    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.upload,
    ));

    // Upload the zip file to Google Drive
    final bool isSuccessful =
        await BackupService.bookRepository.uploadToGoogleDrive(
      zipFile: zipFile,
      onUpload: (int uploaded, int total) {
        emit(BackupServiceProcessItemState(
          step: BackupProgressStepCode.upload,
          progress: (uploaded / total).clamp(0, 1),
        ));
      },
    );

    // Emit the result
    emit(BackupServiceProcessItemState(
      step: isSuccessful
          ? BackupProgressStepCode.done
          : BackupProgressStepCode.error,
    ));

    // Backup progress complete!
    BackupService.bookRepository.finishTask();
  }

  /// Restore the library.
  @override
  Future<void> _restore() async {
    if (!(await BackupService.bookRepository.isBackupExists())) {
      emit(const BackupServiceProcessItemState(
        step: BackupProgressStepCode.disabled,
      ));
      return;
    }

    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.create,
    ));

    // Start the task!
    await BackupService.bookRepository.startTask();

    // Start the download process
    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.download,
    ));

    // Download the zip file
    final File? zipFile =
        await BackupService.bookRepository.downloadFromGoogleDrive(
      onDownload: (int downloaded, int total) {
        emit(BackupServiceProcessItemState(
          step: BackupProgressStepCode.download,
          progress: (downloaded / total).clamp(0, 1),
        ));
      },
    );

    if (zipFile == null) {
      // Download zip file failed.
      emit(const BackupServiceProcessItemState(
        step: BackupProgressStepCode.error,
      ));
    } else {
      // Start extracting the zip file
      emit(const BackupServiceProcessItemState(
        step: BackupProgressStepCode.unzip,
      ));

      // Extract the zip file.
      await BackupService.bookRepository.extract(
        zipFile: zipFile,
        onExtracting: (double progress) {
          emit(BackupServiceProcessItemState(
            step: BackupProgressStepCode.unzip,
            progress: progress / 100,
          ));
        },
      );

      // Restoration completed.
      emit(const BackupServiceProcessItemState(
        step: BackupProgressStepCode.done,
      ));
    }

    // Finish the task
    BackupService.bookRepository.finishTask();
  }

  /// Delete the library.
  @override
  Future<void> _delete() async {
    if (!(await BackupService.bookRepository.isBackupExists())) {
      emit(const BackupServiceProcessItemState(
        step: BackupProgressStepCode.disabled,
      ));
      return;
    }

    // Start the task!
    await BackupService.bookRepository.startTask();

    // Start deleting the backup file.
    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.delete,
    ));

    // Delete the backup file.
    final bool result =
        await BackupService.bookRepository.deleteFromGoogleDrive();

    // Deletion is completed.
    emit(BackupServiceProcessItemState(
      step: result ? BackupProgressStepCode.done : BackupProgressStepCode.error,
    ));

    // Finish the task!
    BackupService.bookRepository.finishTask();
  }
}
