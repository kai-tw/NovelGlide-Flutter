part of '../../../../backup_service.dart';

class BackupServiceProcessBookmarkCubit extends BackupServiceProcessItemCubit {
  BackupServiceProcessBookmarkCubit({super.googleDriveFileId});

  @override
  final BackupTargetType _targetType = BackupTargetType.bookmark;

  /// Backup the bookmark.
  @override
  Future<void> _create() async {
    // Start the upload process
    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.upload,
    ));

    // Start the task!
    await BackupService.bookmarkRepository.startTask();

    // Upload the bookmark json file.
    final bool result =
        await BackupService.bookmarkRepository.uploadToGoogleDrive(
      onUpload: (int uploaded, int total) {
        emit(BackupServiceProcessItemState(
          step: BackupProgressStepCode.upload,
          progress: (uploaded / total).clamp(0, 1),
        ));
      },
    );

    // Emit the result
    emit(BackupServiceProcessItemState(
      step: result ? BackupProgressStepCode.done : BackupProgressStepCode.error,
    ));

    // Finish the task!
    BackupService.bookmarkRepository.finishTask();
  }

  /// Restore the bookmark.
  @override
  Future<void> _restore() async {
    // Start the download process
    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.download,
    ));

    // Start the task!
    await BackupService.bookmarkRepository.startTask();

    // Start downloading the json file.
    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.download,
    ));

    // Download the json file.
    final File? jsonFile =
        await BackupService.bookmarkRepository.downloadFromGoogleDrive(
      onDownload: (int downloaded, int total) {
        emit(BackupServiceProcessItemState(
          step: BackupProgressStepCode.download,
          progress: (downloaded / total).clamp(0, 1),
        ));
      },
    );

    if (jsonFile == null) {
      // Download the json file failed.
      emit(const BackupServiceProcessItemState(
        step: BackupProgressStepCode.error,
      ));
    } else {
      // Import the data.
      await BackupService.bookmarkRepository.importData(jsonFile);

      // Restoration completed.
      emit(const BackupServiceProcessItemState(
        step: BackupProgressStepCode.done,
      ));
    }

    // Finish the task!
    BackupService.bookmarkRepository.finishTask();
  }

  /// Delete the bookmark.
  @override
  Future<void> _delete() async {
    if (googleDriveFileId == null) {
      LogService.error('Google Drive file id of the bookmark backup is null.');
      emit(const BackupServiceProcessItemState(
        step: BackupProgressStepCode.error,
      ));
      return;
    }

    // Start the delete process
    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.delete,
    ));

    // Request the deleting operation
    try {
      await GoogleApiInterfaces.drive.deleteFile(googleDriveFileId!);
    } catch (e) {
      LogService.error(
        'Delete bookmark backup from Google Drive failed.',
        error: e,
      );
      emit(const BackupServiceProcessItemState(
        step: BackupProgressStepCode.error,
      ));
      return;
    }

    // Emit the result
    emit(BackupServiceProcessItemState(
      step: !(await GoogleApiInterfaces.drive
              .fileExists(await BookmarkService.repository.jsonFileName))
          ? BackupProgressStepCode.done
          : BackupProgressStepCode.error,
    ));
  }
}
