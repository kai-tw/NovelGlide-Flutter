part of '../../../../backup_service.dart';

class BackupServiceProcessLibraryCubit extends BackupServiceProcessItemCubit {
  BackupServiceProcessLibraryCubit({super.googleDriveFileId});

  @override
  final BackupServiceTargetType _targetType = BackupServiceTargetType.library;

  /// Backup the library.
  @override
  Future<void> _backup() async {
    // Start backup
    emit(const BackupServiceProcessItemState(
      step: BackupServiceProcessStepCode.backup,
    ));

    // Get a temporary work directory.
    final Directory tempFolder = await RandomUtils.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    // Zip the library
    final File zipFile = await BackupRepository.archiveLibrary(
      tempFolder.path,
      onZipping: (double progress) {
        emit(BackupServiceProcessItemState(
          step: BackupServiceProcessStepCode.zip,
          progress: progress / 100,
        ));
      },
    );

    // Upload the zip file
    emit(const BackupServiceProcessItemState(
      step: BackupServiceProcessStepCode.upload,
    ));

    // Upload the zip file to Google Drive
    try {
      await GoogleApiInterfaces.drive.uploadFile(
        zipFile,
        onUpload: (int uploaded, int total) {
          emit(BackupServiceProcessItemState(
            step: BackupServiceProcessStepCode.upload,
            progress: (uploaded / total).clamp(0, 1),
          ));
        },
      );
      tempFolder.deleteSync(recursive: true);
    } catch (e) {
      LogService.error(
        'Upload library zip to Google Drive failed',
        error: e,
      );
      // An error occurred.
      emit(const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.error,
      ));
      tempFolder.deleteSync(recursive: true);
      return;
    }

    // Emit the result
    emit(BackupServiceProcessItemState(
      step: await GoogleApiInterfaces.drive.fileExists(BackupRepository.libraryArchiveName)
          ? BackupServiceProcessStepCode.done
          : BackupServiceProcessStepCode.error,
    ));
  }

  /// Restore the library.
  @override
  Future<void> _restore() async {
    if (googleDriveFileId == null) {
      LogService.error('Google Drive file id of the library backup is null');
      emit(const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.error,
      ));
      return;
    }

    emit(const BackupServiceProcessItemState(
      step: BackupServiceProcessStepCode.backup,
    ));

    // Get a temporary folder.
    final Directory tempFolder = await RandomUtils.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    // Create an empty file to store the downloaded zip file.
    final File zipFile = File(
      join(tempFolder.path, BackupRepository.libraryArchiveName),
    )..createSync();

    // Start the download process
    emit(const BackupServiceProcessItemState(
      step: BackupServiceProcessStepCode.download,
    ));

    // Download the zip file
    try {
      await GoogleApiInterfaces.drive.downloadFile(
        googleDriveFileId!,
        zipFile,
        onDownload: (int downloaded, int total) {
          emit(BackupServiceProcessItemState(
            step: BackupServiceProcessStepCode.download,
            progress: (downloaded / total).clamp(0, 1),
          ));
        },
      );
    } catch (e) {
      // An error occurred.
      emit(const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.error,
      ));

      // Delete the temporary folder.
      tempFolder.deleteSync(recursive: true);
      return;
    }

    // Extract the zip file
    emit(const BackupServiceProcessItemState(
      step: BackupServiceProcessStepCode.unzip,
    ));
    await BackupRepository.restoreBackup(
      tempFolder,
      zipFile,
      onExtracting: (double progress) {
        emit(BackupServiceProcessItemState(
          step: BackupServiceProcessStepCode.unzip,
          progress: progress / 100,
        ));
      },
    );

    // Restoration completed.
    tempFolder.deleteSync(recursive: true);
    emit(const BackupServiceProcessItemState(
      step: BackupServiceProcessStepCode.done,
    ));
  }

  /// Delete the library.
  @override
  Future<void> _delete() async {
    if (googleDriveFileId == null) {
      LogService.error('Google Drive file id of the library backup is null');
      emit(const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.error,
      ));
      return;
    }

    emit(const BackupServiceProcessItemState(
      step: BackupServiceProcessStepCode.delete,
    ));
    await GoogleApiInterfaces.drive.deleteFile(googleDriveFileId!);
    final bool result = !(await GoogleApiInterfaces.drive.fileExists(BackupRepository.libraryArchiveName));
    emit(BackupServiceProcessItemState(
      step: result ? BackupServiceProcessStepCode.done : BackupServiceProcessStepCode.error,
    ));
  }
}
