import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../../../../repository/bookmark_repository.dart';
import '../../../../../../repository/collection_repository.dart';
import '../../../../../../utils/backup_utils.dart';
import '../../../../../../utils/google_drive_api.dart';
import '../../../../../../utils/random_utils.dart';

part 'backup_service_process_item_state.dart';
part 'backup_service_process_state.dart';
part 'backup_service_process_step_code.dart';
part 'backup_service_target_type.dart';
part 'backup_service_task_type.dart';

class BackupServiceProcessCubit extends Cubit<BackupServiceProcessState> {
  BackupServiceProcessCubit({
    required this.libraryId,
    required this.collectionId,
    required this.bookmarkId,
  }) : super(const BackupServiceProcessState());

  final String libraryId;
  final String collectionId;
  final String bookmarkId;

  Future<void> start(
    BackupServiceTaskType taskType,
    BackupServiceTargetType targetType,
  ) async {
    switch (taskType) {
      case BackupServiceTaskType.backup:
        switch (targetType) {
          case BackupServiceTargetType.all:
            backupAll();
            break;
          case BackupServiceTargetType.library:
            backupLibrary();
            break;
          case BackupServiceTargetType.collection:
            backupCollections();
            break;
          case BackupServiceTargetType.bookmark:
            backupBookmarks();
            break;
        }
        break;
      case BackupServiceTaskType.restore:
        switch (targetType) {
          case BackupServiceTargetType.all:
            restoreAll();
            break;
          case BackupServiceTargetType.library:
            restoreLibrary();
            break;
          case BackupServiceTargetType.collection:
            restoreCollections();
            break;
          case BackupServiceTargetType.bookmark:
            restoreBookmarks();
            break;
        }
        break;
      case BackupServiceTaskType.delete:
        switch (targetType) {
          case BackupServiceTargetType.all:
            deleteAll();
            break;
          case BackupServiceTargetType.library:
            deleteLibrary();
            break;
          case BackupServiceTargetType.collection:
            deleteCollections();
            break;
          case BackupServiceTargetType.bookmark:
            deleteBookmarks();
            break;
        }
        break;
    }
  }

  Future<void> backupAll() async {
    Future.wait(<Future<void>>[
      backupLibrary(),
      backupBookmarks(),
      backupCollections(),
    ]);
  }

  Future<void> backupLibrary() async {
    emit(state.copyWith(
      library: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.idle,
      ),
    ));

    final Directory tempFolder = RandomUtils.getAvailableTempFolder()
      ..createSync(recursive: true);

    // Zip the library
    final File zipFile = await BackupUtils.archiveLibrary(
      tempFolder.path,
      onZipping: (double progress) {
        emit(state.copyWith(
          library: BackupServiceProcessItemState(
            step: BackupServiceProcessStepCode.zip,
            progress: progress / 100,
          ),
        ));
      },
    );

    // Upload the zip file
    emit(state.copyWith(
      library: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.upload,
      ),
    ));
    await GoogleDriveApi.uploadFile('appDataFolder', zipFile);
    tempFolder.deleteSync(recursive: true);

    final bool result =
        await GoogleDriveApi.fileExists(BackupUtils.libraryArchiveName);
    emit(state.copyWith(
      library: BackupServiceProcessItemState(
        step: result
            ? BackupServiceProcessStepCode.done
            : BackupServiceProcessStepCode.error,
      ),
    ));
  }

  Future<void> backupBookmarks() async {
    // Upload the bookmark file
    emit(state.copyWith(
      bookmark: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.upload,
      ),
    ));
    final File bookmarkFile = BookmarkRepository.jsonFile;
    await GoogleDriveApi.uploadFile('appDataFolder', bookmarkFile);

    // Emit the result
    final bool result =
        await GoogleDriveApi.fileExists(BookmarkRepository.jsonFileName);
    emit(state.copyWith(
      bookmark: BackupServiceProcessItemState(
        step: result
            ? BackupServiceProcessStepCode.done
            : BackupServiceProcessStepCode.error,
      ),
    ));
  }

  Future<void> backupCollections() async {
    emit(state.copyWith(
      collection: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.upload,
      ),
    ));
    final File collectionFile = CollectionRepository.jsonFile;
    await GoogleDriveApi.uploadFile('appDataFolder', collectionFile);

    final bool result =
        await GoogleDriveApi.fileExists(CollectionRepository.jsonFileName);
    emit(state.copyWith(
      collection: BackupServiceProcessItemState(
        step: result
            ? BackupServiceProcessStepCode.done
            : BackupServiceProcessStepCode.error,
      ),
    ));
  }

  Future<void> deleteAll() async {
    await Future.wait(<Future<void>>[
      deleteLibrary(),
      deleteCollections(),
      deleteBookmarks(),
    ]);
  }

  Future<void> deleteLibrary() async {
    emit(state.copyWith(
      library: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.delete,
      ),
    ));
    await GoogleDriveApi.deleteFile(libraryId);
    final bool result =
        !(await GoogleDriveApi.fileExists(BackupUtils.libraryArchiveName));
    emit(state.copyWith(
      library: BackupServiceProcessItemState(
        step: result
            ? BackupServiceProcessStepCode.done
            : BackupServiceProcessStepCode.error,
      ),
    ));
  }

  Future<void> deleteBookmarks() async {
    emit(state.copyWith(
      bookmark: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.delete,
      ),
    ));
    await GoogleDriveApi.deleteFile(bookmarkId);
    final bool result =
        !(await GoogleDriveApi.fileExists(BookmarkRepository.jsonFileName));
    emit(state.copyWith(
      bookmark: BackupServiceProcessItemState(
        step: result
            ? BackupServiceProcessStepCode.done
            : BackupServiceProcessStepCode.error,
      ),
    ));
  }

  Future<void> deleteCollections() async {
    emit(state.copyWith(
      collection: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.delete,
      ),
    ));
    await GoogleDriveApi.deleteFile(collectionId);
    final bool result =
        !(await GoogleDriveApi.fileExists(CollectionRepository.jsonFileName));
    emit(state.copyWith(
      collection: BackupServiceProcessItemState(
        step: result
            ? BackupServiceProcessStepCode.done
            : BackupServiceProcessStepCode.error,
      ),
    ));
  }

  Future<void> restoreAll() async {
    await Future.wait(<Future<void>>[
      restoreLibrary(),
      restoreCollections(),
      restoreBookmarks(),
    ]);
  }

  Future<void> restoreLibrary() async {
    emit(state.copyWith(
      library: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.idle,
      ),
    ));
    // Get a temporary folder.
    final Directory tempFolder = RandomUtils.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    // Create an empty file to store the downloaded zip file.
    final File zipFile = File(
      join(tempFolder.path, BackupUtils.libraryArchiveName),
    )..createSync();

    // Download the zip file
    try {
      await GoogleDriveApi.downloadFile(
        libraryId,
        zipFile,
        onDownload: (int downloaded, int total) {
          emit(state.copyWith(
            library: BackupServiceProcessItemState(
              step: BackupServiceProcessStepCode.download,
              progress: (downloaded / total).clamp(0, 1),
            ),
          ));
        },
      );
    } catch (e) {
      // An error occurred.
      emit(state.copyWith(
        library: const BackupServiceProcessItemState(
          step: BackupServiceProcessStepCode.error,
        ),
      ));

      // Delete the temporary folder.
      tempFolder.deleteSync(recursive: true);
      return;
    }

    // Extract the zip file
    emit(state.copyWith(
      library: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.unzip,
      ),
    ));
    await BackupUtils.restoreBackup(
      tempFolder,
      zipFile,
      onExtracting: (double progress) {
        emit(state.copyWith(
          library: BackupServiceProcessItemState(
            step: BackupServiceProcessStepCode.unzip,
            progress: progress / 100,
          ),
        ));
      },
    );

    // Restoration completed.
    tempFolder.deleteSync(recursive: true);
    emit(state.copyWith(
      library: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.done,
      ),
    ));
  }

  Future<void> restoreBookmarks() async {
    // Download the json file.
    try {
      await GoogleDriveApi.downloadFile(
        bookmarkId,
        BookmarkRepository.jsonFile,
        onDownload: (int downloaded, int total) {
          emit(state.copyWith(
            bookmark: BackupServiceProcessItemState(
              step: BackupServiceProcessStepCode.download,
              progress: (downloaded / total).clamp(0, 1),
            ),
          ));
        },
      );
    } catch (e) {
      // An error occurred.
      emit(state.copyWith(
        bookmark: const BackupServiceProcessItemState(
          step: BackupServiceProcessStepCode.error,
        ),
      ));
      return;
    }

    // Restoration completed.
    emit(state.copyWith(
      bookmark: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.done,
      ),
    ));
  }

  Future<void> restoreCollections() async {
    // Download the json file.
    try {
      await GoogleDriveApi.downloadFile(
        collectionId,
        CollectionRepository.jsonFile,
        onDownload: (int downloaded, int total) {
          emit(state.copyWith(
            collection: const BackupServiceProcessItemState(
              step: BackupServiceProcessStepCode.download,
            ),
          ));
        },
      );
    } catch (e) {
      // An error occurred.
      emit(state.copyWith(
        collection: const BackupServiceProcessItemState(
          step: BackupServiceProcessStepCode.error,
        ),
      ));
      return;
    }

    // Restoration completed.
    emit(state.copyWith(
      collection: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.done,
      ),
    ));
  }
}
