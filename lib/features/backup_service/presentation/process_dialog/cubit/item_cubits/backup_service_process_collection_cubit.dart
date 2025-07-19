part of '../../../../backup_service.dart';

class BackupServiceProcessCollectionCubit
    extends BackupServiceProcessItemCubit {
  BackupServiceProcessCollectionCubit({super.googleDriveFileId});

  @override
  final BackupServiceTargetType _targetType =
      BackupServiceTargetType.collection;

  /// Backup the collection.
  @override
  Future<void> _backup() async {
    // Start the upload process
    emit(const BackupServiceProcessItemState(
      step: BackupServiceProcessStepCode.upload,
    ));

    // Upload the collection json file
    await GoogleApiInterfaces.drive.uploadFile(
      CollectionService.repository.jsonFile,
      onUpload: (int uploaded, int total) {
        // Update the progress
        emit(BackupServiceProcessItemState(
          step: BackupServiceProcessStepCode.upload,
          progress: (uploaded / total).clamp(0, 1),
        ));
      },
    );

    // Emit the result
    emit(BackupServiceProcessItemState(
      step: await GoogleApiInterfaces.drive
              .fileExists(CollectionService.repository.jsonFileName)
          ? BackupServiceProcessStepCode.done
          : BackupServiceProcessStepCode.error,
    ));
  }

  /// Restore the collection.
  @override
  Future<void> _restore() async {
    if (googleDriveFileId == null) {
      LogService.info('Google Drive file id of the collection backup is null.');
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
        CollectionService.repository.jsonFile,
        onDownload: (int downloaded, int total) {
          // Update the progress
          emit(BackupServiceProcessItemState(
            step: BackupServiceProcessStepCode.download,
            progress: (downloaded / total).clamp(0, 1),
          ));
        },
      );
    } catch (e) {
      LogService.error(
        'Failed to download collection backup from Google Drive',
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

  /// Delete the collection.
  @override
  Future<void> _delete() async {
    if (googleDriveFileId == null) {
      LogService.error(
          'Google Drive file id of the collection backup is null.');
      emit(const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.error,
      ));
      return;
    }

    // Start the delete process
    emit(const BackupServiceProcessItemState(
      step: BackupServiceProcessStepCode.delete,
    ));

    // Delete the collection json file from Google Drive
    try {
      await GoogleApiInterfaces.drive.deleteFile(googleDriveFileId!);
    } catch (e) {
      LogService.error(
        'Failed to delete collection backup from Google Drive.',
        error: e,
      );
      emit(const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.error,
      ));
      return;
    }

    emit(BackupServiceProcessItemState(
      step: !(await GoogleApiInterfaces.drive
              .fileExists(CollectionService.repository.jsonFileName))
          ? BackupServiceProcessStepCode.done
          : BackupServiceProcessStepCode.error,
    ));
  }
}
