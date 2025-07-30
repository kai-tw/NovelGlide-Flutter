part of '../../../../backup_service.dart';

class BackupServiceProcessCollectionCubit
    extends BackupServiceProcessItemCubit {
  BackupServiceProcessCollectionCubit({super.googleDriveFileId});

  @override
  final BackupTargetType _targetType = BackupTargetType.collection;

  /// Back collections up
  @override
  Future<void> _create() async {
    // Start the upload process
    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.upload,
    ));

    // Start the task!
    await BackupService.collectionRepository.startTask();

    // Upload the collection json file
    final bool result = await BackupService.collectionRepository
        .uploadToGoogleDrive(onUpload: (int uploaded, int total) {
      // Update the progress
      emit(BackupServiceProcessItemState(
        step: BackupProgressStepCode.upload,
        progress: (uploaded / total).clamp(0, 1),
      ));
    });

    // Emit the result
    emit(BackupServiceProcessItemState(
      step: result ? BackupProgressStepCode.done : BackupProgressStepCode.error,
    ));

    // Finish the task!
    BackupService.collectionRepository.finishTask();
  }

  /// Restore from the collection backup.
  @override
  Future<void> _restore() async {
    // Start the download process
    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.download,
    ));

    // Download the json file.
    final File? jsonFile = await BackupService.collectionRepository
        .downloadFromGoogleDrive(onDownload: (int downloaded, int total) {
      // Update the progress
      emit(BackupServiceProcessItemState(
        step: BackupProgressStepCode.download,
        progress: (downloaded / total).clamp(0, 1),
      ));
    });

    if (jsonFile == null) {
      // Downloading file was failed.
      emit(const BackupServiceProcessItemState(
        step: BackupProgressStepCode.error,
      ));
    } else {
      // Downloading file was successful.
      await BackupService.collectionRepository.importData(jsonFile);
    }

    // Restoration completed.
    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.done,
    ));

    // Finish the task
    BackupService.collectionRepository.finishTask();
  }

  /// Delete the collection backup.
  @override
  Future<void> _delete() async {
    // Start the delete process
    emit(const BackupServiceProcessItemState(
      step: BackupProgressStepCode.delete,
    ));

    // Start the task!
    await BackupService.collectionRepository.startTask();

    // Delete the file
    final bool result =
        await BackupService.collectionRepository.deleteFromGoogleDrive();

    // Emit the result
    emit(BackupServiceProcessItemState(
      step: result ? BackupProgressStepCode.done : BackupProgressStepCode.error,
    ));

    // Finish the task
    BackupService.collectionRepository.finishTask();
  }
}
