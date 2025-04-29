import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../enum/loading_state_code.dart';
import '../../../../../../preference_keys/preference_keys.dart';
import '../../../../../core/services/google_drive_service.dart';
import '../../../../bookmark/data/bookmark_repository.dart';
import '../../../../collection/data/collection_repository.dart';
import '../../../data/repository/backup_repository.dart';

part 'backup_service_google_drive_state.dart';

/// Manages Google Drive backup operations.
class BackupServiceGoogleDriveCubit
    extends Cubit<BackupServiceGoogleDriveState> {
  factory BackupServiceGoogleDriveCubit() {
    const BackupServiceGoogleDriveState initialState =
        BackupServiceGoogleDriveState();
    final BackupServiceGoogleDriveCubit cubit =
        BackupServiceGoogleDriveCubit._internal(initialState);
    cubit.refresh();
    return cubit;
  }

  BackupServiceGoogleDriveCubit._internal(super.initialState);

  /// Refreshes the backup state by checking preferences and updating metadata.
  Future<void> refresh() async {
    emit(const BackupServiceGoogleDriveState(code: LoadingStateCode.loading));

    // Load preferences.
    final String key = PreferenceKeys.backupService.isBackupToGoogleDrive;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isEnabled = prefs.getBool(key) ?? false;

    if (isEnabled && !(await GoogleDriveService.isSignedIn())) {
      await GoogleDriveService.signIn();
    }

    if (await GoogleDriveService.isSignedIn()) {
      // Load the file IDs.
      final List<String> fileNameList = <String>[
        BackupRepository.libraryArchiveName,
        CollectionRepository.jsonFileName,
        BookmarkRepository.jsonFileName,
      ];
      final List<String?> fileIdList = await Future.wait<String?>(
        fileNameList
            .map((String fileName) => GoogleDriveService.getFileId(fileName)),
      );

      // Get the last backup time.
      final List<DateTime> timeList = (await Future.wait<drive.File>(
        fileIdList.whereType<String>().map((String fileId) =>
            GoogleDriveService.getMetadataById(fileId, field: 'modifiedTime')),
      ))
          .map((drive.File e) => e.modifiedTime)
          .whereType<DateTime>()
          .toList();
      final DateTime? lastBackupTime = timeList.isNotEmpty
          ? timeList.reduce((DateTime a, DateTime b) => a.isAfter(b) ? a : b)
          : null;

      if (!isClosed) {
        emit(BackupServiceGoogleDriveState(
          code: LoadingStateCode.loaded,
          libraryId: fileIdList[0],
          collectionId: fileIdList[1],
          bookmarkId: fileIdList[2],
          lastBackupTime: lastBackupTime,
        ));
      }
    } else if (!isClosed) {
      emit(const BackupServiceGoogleDriveState());
    }
  }

  /// Sets the backup enabled state and manages sign-in status.
  Future<void> setEnabled(bool isEnabled) async {
    final String key = PreferenceKeys.backupService.isBackupToGoogleDrive;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isSignedIn = await GoogleDriveService.isSignedIn();

    if (isEnabled != isSignedIn) {
      isEnabled
          ? await GoogleDriveService.signIn()
          : await GoogleDriveService.signOut();
    }

    await prefs.setBool(key, await GoogleDriveService.isSignedIn());
  }
}
