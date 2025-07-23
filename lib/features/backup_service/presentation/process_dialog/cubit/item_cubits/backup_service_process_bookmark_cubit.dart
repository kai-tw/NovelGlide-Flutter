part of '../../../../backup_service.dart';

class BackupServiceProcessBookmarkCubit extends BackupServiceProcessItemCubit {
  BackupServiceProcessBookmarkCubit({super.googleDriveFileId});

  @override
  final BackupServiceTargetType _targetType = BackupServiceTargetType.bookmark;

  /// Backup the bookmark.
  @override
  Future<void> _backup() async {
    // Start the upload process
    emit(const BackupServiceProcessItemState(
      step: BackupServiceProcessStepCode.upload,
    ));

    // Upload the bookmark json file.
    try {
      await GoogleApiInterfaces.drive.uploadFile(
        await BookmarkService.repository.jsonFile,
        onUpload: (int uploaded, int total) {
          emit(BackupServiceProcessItemState(
            step: BackupServiceProcessStepCode.upload,
            progress: (uploaded / total).clamp(0, 1),
          ));
        },
      );
    } catch (e) {
      LogDomain.error(
        'Upload bookmark backup to Google Drive failed.',
        error: e,
      );
      emit(const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.error,
      ));
      return;
    }

    // Emit the result
    emit(BackupServiceProcessItemState(
      step: await GoogleApiInterfaces.drive
              .fileExists(await BookmarkService.repository.jsonFileName)
          ? BackupServiceProcessStepCode.done
          : BackupServiceProcessStepCode.error,
    ));
  }

  /// Restore the bookmark.
  @override
  Future<void> _restore() async {
    if (googleDriveFileId == null) {
      LogDomain.error('Google Drive file id of the bookmark backup is null.');
      emit(const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.error,
      ));
      return;
    }

    // Start the download process
    emit(const BackupServiceProcessItemState(
      step: BackupServiceProcessStepCode.download,
    ));

    // Download the json file.
    try {
      await GoogleApiInterfaces.drive.downloadFile(
        googleDriveFileId!,
        await BookmarkService.repository.jsonFile,
        onDownload: (int downloaded, int total) {
          // Update the progress
          emit(BackupServiceProcessItemState(
            step: BackupServiceProcessStepCode.download,
            progress: (downloaded / total).clamp(0, 1),
          ));
        },
      );
    } catch (e) {
      LogDomain.error(
        'Download bookmark backup from Google Drive failed.',
        error: e,
      );
      emit(const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.error,
      ));
      return;
    }

    // Restoration completed.
    emit(const BackupServiceProcessItemState(
      step: BackupServiceProcessStepCode.done,
    ));
  }

  /// Delete the bookmark.
  @override
  Future<void> _delete() async {
    if (googleDriveFileId == null) {
      LogDomain.error('Google Drive file id of the bookmark backup is null.');
      emit(const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.error,
      ));
      return;
    }

    // Start the delete process
    emit(const BackupServiceProcessItemState(
      step: BackupServiceProcessStepCode.delete,
    ));

    // Request the deleting operation
    try {
      await GoogleApiInterfaces.drive.deleteFile(googleDriveFileId!);
    } catch (e) {
      LogDomain.error(
        'Delete bookmark backup from Google Drive failed.',
        error: e,
      );
      emit(const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.error,
      ));
      return;
    }

    // Emit the result
    emit(BackupServiceProcessItemState(
      step: !(await GoogleApiInterfaces.drive
              .fileExists(await BookmarkService.repository.jsonFileName))
          ? BackupServiceProcessStepCode.done
          : BackupServiceProcessStepCode.error,
    ));
  }
}
