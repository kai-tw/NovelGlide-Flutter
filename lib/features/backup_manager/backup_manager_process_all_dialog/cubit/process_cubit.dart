import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../../../../repository/bookmark_repository.dart';
import '../../../../../../repository/collection_repository.dart';
import '../../../../../../utils/backup_utils.dart';
import '../../../../../../utils/google_drive_api.dart';
import '../../../../../../utils/random_utils.dart';

part 'process_step_code.dart';
part 'state.dart';
part 'target_type.dart';
part 'task_type.dart';

class ProcessAllDialogCubit extends Cubit<BackupManagerProcessAllDialogState> {
  final _driveApi = GoogleDriveApi.instance;
  final String libraryId;
  final String collectionId;
  final String bookmarkId;

  ProcessAllDialogCubit({
    required this.libraryId,
    required this.collectionId,
    required this.bookmarkId,
  }) : super(const BackupManagerProcessAllDialogState());

  Future<void> start(
    BackupManagerTaskType taskType,
    BackupManagerTargetType targetType,
  ) async {
    switch (taskType) {
      case BackupManagerTaskType.backup:
        switch (targetType) {
          case BackupManagerTargetType.all:
            backupAll();
            break;
          case BackupManagerTargetType.library:
            backupLibrary();
            break;
          case BackupManagerTargetType.collection:
            backupCollections();
            break;
          case BackupManagerTargetType.bookmark:
            backupBookmarks();
            break;
        }
        break;
      case BackupManagerTaskType.restore:
        switch (targetType) {
          case BackupManagerTargetType.all:
            restoreAll();
            break;
          case BackupManagerTargetType.library:
            restoreLibrary();
            break;
          case BackupManagerTargetType.collection:
            restoreCollections();
            break;
          case BackupManagerTargetType.bookmark:
            restoreBookmarks();
            break;
        }
        break;
      case BackupManagerTaskType.delete:
        switch (targetType) {
          case BackupManagerTargetType.all:
            deleteAll();
            break;
          case BackupManagerTargetType.library:
            deleteLibrary();
            break;
          case BackupManagerTargetType.collection:
            deleteCollections();
            break;
          case BackupManagerTargetType.bookmark:
            deleteBookmarks();
            break;
        }
        break;
    }
  }

  Future<void> backupAll() async {
    Future.wait([
      backupLibrary(),
      backupBookmarks(),
      backupCollections(),
    ]);
  }

  Future<void> backupLibrary() async {
    emit(state.copyWith(
      isLibraryRunning: true,
      libraryStep: BackupManagerProcessStepCode.idle,
    ));

    final tempFolder = RandomUtils.getAvailableTempFolder()
      ..createSync(recursive: true);

    // Zip the library
    final zipFile = await BackupUtils.archiveLibrary(
      tempFolder.path,
      onZipping: (progress) {
        emit(state.copyWith(
          libraryStep: BackupManagerProcessStepCode.zip,
          libraryProgress: progress / 100,
        ));
      },
    );

    // Upload the zip file
    emit(state.copyWith(libraryStep: BackupManagerProcessStepCode.upload));
    await _driveApi.uploadFile('appDataFolder', zipFile);
    tempFolder.deleteSync(recursive: true);

    final result = await _driveApi.fileExists(BackupUtils.libraryArchiveName);
    emit(state.copyWith(
      libraryStep: result
          ? BackupManagerProcessStepCode.done
          : BackupManagerProcessStepCode.error,
    ));
  }

  Future<void> backupBookmarks() async {
    // Upload the bookmark file
    emit(state.copyWith(
      isBookmarkRunning: true,
      bookmarkStep: BackupManagerProcessStepCode.upload,
    ));
    final bookmarkFile = BookmarkRepository.jsonFile;
    await _driveApi.uploadFile('appDataFolder', bookmarkFile);

    // Emit the result
    final result = await _driveApi.fileExists(BookmarkRepository.jsonFileName);
    emit(state.copyWith(
      bookmarkStep: result
          ? BackupManagerProcessStepCode.done
          : BackupManagerProcessStepCode.error,
    ));
  }

  Future<void> backupCollections() async {
    emit(state.copyWith(
      isCollectionRunning: true,
      collectionStep: BackupManagerProcessStepCode.upload,
    ));
    final collectionFile = CollectionRepository.jsonFile;
    await _driveApi.uploadFile('appDataFolder', collectionFile);

    final result =
        await _driveApi.fileExists(CollectionRepository.jsonFileName);
    emit(state.copyWith(
      collectionStep: result
          ? BackupManagerProcessStepCode.done
          : BackupManagerProcessStepCode.error,
    ));
  }

  Future<void> deleteAll() async {
    await Future.wait([
      deleteLibrary(),
      deleteCollections(),
      deleteBookmarks(),
    ]);
  }

  Future<void> deleteLibrary() async {
    emit(state.copyWith(
      isLibraryRunning: true,
      libraryStep: BackupManagerProcessStepCode.delete,
    ));
    await _driveApi.deleteFile(libraryId);
    final result =
        !(await _driveApi.fileExists(BackupUtils.libraryArchiveName));
    emit(state.copyWith(
      libraryStep: result
          ? BackupManagerProcessStepCode.done
          : BackupManagerProcessStepCode.error,
    ));
  }

  Future<void> deleteBookmarks() async {
    emit(state.copyWith(
      isBookmarkRunning: true,
      bookmarkStep: BackupManagerProcessStepCode.delete,
    ));
    await _driveApi.deleteFile(bookmarkId);
    final result =
        !(await _driveApi.fileExists(BookmarkRepository.jsonFileName));
    emit(state.copyWith(
      bookmarkStep: result
          ? BackupManagerProcessStepCode.done
          : BackupManagerProcessStepCode.error,
    ));
  }

  Future<void> deleteCollections() async {
    emit(state.copyWith(
      isCollectionRunning: true,
      collectionStep: BackupManagerProcessStepCode.delete,
    ));
    await _driveApi.deleteFile(collectionId);
    final result =
        !(await _driveApi.fileExists(CollectionRepository.jsonFileName));
    emit(state.copyWith(
      collectionStep: result
          ? BackupManagerProcessStepCode.done
          : BackupManagerProcessStepCode.error,
    ));
  }

  Future<void> restoreAll() async {
    await Future.wait([
      restoreLibrary(),
      restoreCollections(),
      restoreBookmarks(),
    ]);
  }

  Future<void> restoreLibrary() async {
    emit(state.copyWith(
      isLibraryRunning: true,
      libraryStep: BackupManagerProcessStepCode.idle,
    ));
    final tempFolder = RandomUtils.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    final zipFile = File(
      join(
        tempFolder.path,
        BackupUtils.libraryArchiveName,
      ),
    )..createSync();

    // Download the zip file
    await _driveApi.downloadFile(
      libraryId,
      zipFile,
      onDownload: (downloaded, total) {
        emit(state.copyWith(
          libraryStep: BackupManagerProcessStepCode.download,
          libraryProgress: (downloaded / total).clamp(0, 1),
        ));
      },
    );

    // Extract the zip file
    emit(state.copyWith(libraryStep: BackupManagerProcessStepCode.unzip));
    await BackupUtils.restoreBackup(
      tempFolder,
      zipFile,
      onExtracting: (progress) {
        emit(state.copyWith(
          libraryStep: BackupManagerProcessStepCode.unzip,
          libraryProgress: progress / 100,
        ));
      },
    );

    tempFolder.deleteSync(recursive: true);
    emit(state.copyWith(libraryStep: BackupManagerProcessStepCode.done));
  }

  Future<void> restoreBookmarks() async {
    emit(state.copyWith(
      isBookmarkRunning: true,
      bookmarkStep: BackupManagerProcessStepCode.download,
    ));
    await _driveApi.downloadFile(bookmarkId, BookmarkRepository.jsonFile);
    emit(state.copyWith(bookmarkStep: BackupManagerProcessStepCode.done));
  }

  Future<void> restoreCollections() async {
    emit(state.copyWith(
      isCollectionRunning: true,
      collectionStep: BackupManagerProcessStepCode.download,
    ));
    await _driveApi.downloadFile(collectionId, CollectionRepository.jsonFile);
    emit(state.copyWith(collectionStep: BackupManagerProcessStepCode.done));
  }
}
