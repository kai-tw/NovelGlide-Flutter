import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../../../core/services/google_api_interfaces/google_api_interfaces.dart';
import '../../../../../core/utils/random_utils.dart';
import '../../../../bookmark/data/bookmark_repository.dart';
import '../../../../collection/data/collection_repository.dart';
import '../../../data/repository/backup_repository.dart';

part 'backup_service_process_item_state.dart';
part 'backup_service_process_state.dart';
part 'backup_service_process_step_code.dart';
part 'backup_service_target_type.dart';
part 'backup_service_task_type.dart';

class BackupServiceProcessCubit extends Cubit<BackupServiceProcessState> {
  BackupServiceProcessCubit({
    this.libraryId,
    this.collectionId,
    this.bookmarkId,
  }) : super(const BackupServiceProcessState());

  final String? libraryId;
  final String? collectionId;
  final String? bookmarkId;

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
        step: BackupServiceProcessStepCode.backup,
      ),
    ));

    final Directory tempFolder = RandomUtils.getAvailableTempFolder()..createSync(recursive: true);

    // Zip the library
    final File zipFile = await BackupRepository.archiveLibrary(
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

    // Upload the zip file to Google Drive
    await GoogleApiInterfaces.drive.uploadFile(
      zipFile,
      onUpload: (int uploaded, int total) {
        emit(state.copyWith(
          library: BackupServiceProcessItemState(
            step: BackupServiceProcessStepCode.upload,
            progress: (uploaded / total).clamp(0, 1),
          ),
        ));
      },
    );
    tempFolder.deleteSync(recursive: true);

    // Emit the result
    emit(state.copyWith(
      library: BackupServiceProcessItemState(
        step: await GoogleApiInterfaces.drive.fileExists(BackupRepository.libraryArchiveName)
            ? BackupServiceProcessStepCode.done
            : BackupServiceProcessStepCode.error,
      ),
    ));
  }

  Future<void> backupBookmarks() async {
    // Start the upload process
    emit(state.copyWith(
      bookmark: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.upload,
      ),
    ));

    // Upload the bookmark json file.
    await GoogleApiInterfaces.drive.uploadFile(
      BookmarkRepository.jsonFile,
      onUpload: (int uploaded, int total) {
        emit(state.copyWith(
          bookmark: BackupServiceProcessItemState(
            step: BackupServiceProcessStepCode.upload,
            progress: (uploaded / total).clamp(0, 1),
          ),
        ));
      },
    );

    // Emit the result
    emit(state.copyWith(
      bookmark: BackupServiceProcessItemState(
        step: await GoogleApiInterfaces.drive.fileExists(BookmarkRepository.jsonFileName)
            ? BackupServiceProcessStepCode.done
            : BackupServiceProcessStepCode.error,
      ),
    ));
  }

  Future<void> backupCollections() async {
    // Start the upload process
    emit(state.copyWith(
      collection: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.upload,
      ),
    ));

    // Upload the collection json file
    await GoogleApiInterfaces.drive.uploadFile(
      CollectionRepository.jsonFile,
      onUpload: (int uploaded, int total) {
        emit(state.copyWith(
          collection: BackupServiceProcessItemState(
            step: BackupServiceProcessStepCode.upload,
            progress: (uploaded / total).clamp(0, 1),
          ),
        ));
      },
    );

    // Emit the result
    emit(state.copyWith(
      collection: BackupServiceProcessItemState(
        step: await GoogleApiInterfaces.drive.fileExists(CollectionRepository.jsonFileName)
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
    if (libraryId == null) {
      return;
    }

    emit(state.copyWith(
      library: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.delete,
      ),
    ));
    await GoogleApiInterfaces.drive.deleteFile(libraryId!);
    final bool result = !(await GoogleApiInterfaces.drive.fileExists(BackupRepository.libraryArchiveName));
    emit(state.copyWith(
      library: BackupServiceProcessItemState(
        step: result ? BackupServiceProcessStepCode.done : BackupServiceProcessStepCode.error,
      ),
    ));
  }

  Future<void> deleteBookmarks() async {
    if (bookmarkId == null) {
      return;
    }

    emit(state.copyWith(
      bookmark: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.delete,
      ),
    ));
    await GoogleApiInterfaces.drive.deleteFile(bookmarkId!);
    final bool result = !(await GoogleApiInterfaces.drive.fileExists(BookmarkRepository.jsonFileName));
    emit(state.copyWith(
      bookmark: BackupServiceProcessItemState(
        step: result ? BackupServiceProcessStepCode.done : BackupServiceProcessStepCode.error,
      ),
    ));
  }

  Future<void> deleteCollections() async {
    if (collectionId == null) {
      return;
    }

    emit(state.copyWith(
      collection: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.delete,
      ),
    ));
    await GoogleApiInterfaces.drive.deleteFile(collectionId!);
    final bool result = !(await GoogleApiInterfaces.drive.fileExists(CollectionRepository.jsonFileName));
    emit(state.copyWith(
      collection: BackupServiceProcessItemState(
        step: result ? BackupServiceProcessStepCode.done : BackupServiceProcessStepCode.error,
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
    if (libraryId == null) {
      return;
    }

    emit(state.copyWith(
      library: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.backup,
      ),
    ));

    // Get a temporary folder.
    final Directory tempFolder = RandomUtils.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    // Create an empty file to store the downloaded zip file.
    final File zipFile = File(
      join(tempFolder.path, BackupRepository.libraryArchiveName),
    )..createSync();

    // Download the zip file
    try {
      await GoogleApiInterfaces.drive.downloadFile(
        libraryId!,
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
    await BackupRepository.restoreBackup(
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
    if (bookmarkId == null) {
      return;
    }

    emit(state.copyWith(
      bookmark: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.download,
      ),
    ));

    // Download the json file.
    try {
      await GoogleApiInterfaces.drive.downloadFile(
        bookmarkId!,
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
    if (collectionId == null) {
      return;
    }

    emit(state.copyWith(
      collection: const BackupServiceProcessItemState(
        step: BackupServiceProcessStepCode.download,
      ),
    ));

    // Download the json file.
    try {
      await GoogleApiInterfaces.drive.downloadFile(
        collectionId!,
        CollectionRepository.jsonFile,
        onDownload: (int downloaded, int total) {
          emit(state.copyWith(
            collection: BackupServiceProcessItemState(
              step: BackupServiceProcessStepCode.download,
              progress: (downloaded / total).clamp(0, 1),
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
