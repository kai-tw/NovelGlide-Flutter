import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../enum/loading_state_code.dart';
import '../../../../preference_keys/preference_keys.dart';
import '../../../../repository/bookmark_repository.dart';
import '../../../../repository/collection_repository.dart';
import '../../../../utils/backup_utils.dart';
import '../../../../utils/google_drive_api.dart';

part 'backup_manager_google_drive_state.dart';

/// Manages Google Drive backup operations.
class BackupManagerGoogleDriveCubit
    extends Cubit<BackupManagerGoogleDriveState> {
  factory BackupManagerGoogleDriveCubit() {
    const BackupManagerGoogleDriveState initialState =
        BackupManagerGoogleDriveState();
    final BackupManagerGoogleDriveCubit cubit =
        BackupManagerGoogleDriveCubit._internal(initialState);
    cubit.refresh();
    return cubit;
  }

  BackupManagerGoogleDriveCubit._internal(super.initialState);

  final Logger _logger = Logger();

  /// Refreshes the backup state by checking preferences and updating metadata.
  Future<void> refresh() async {
    emit(const BackupManagerGoogleDriveState(code: LoadingStateCode.loading));
    final String key = PreferenceKeys.backupManager.isBackupToGoogleDrive;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setEnabled(prefs.getBool(key) ?? false);

    final bool isSignedIn = await GoogleDriveApi.isSignedIn();

    if (isSignedIn) {
      final List<String> fileNameList = <String>[
        BackupUtils.libraryArchiveName,
        CollectionRepository.jsonFileName,
        BookmarkRepository.jsonFileName,
      ];
      final List<String?> fileIdList = await Future.wait<String?>(
        fileNameList
            .map((String fileName) => GoogleDriveApi.getFileId(fileName)),
      );
      final List<DateTime> timeList = (await Future.wait<drive.File>(
        fileIdList.whereType<String>().map((String fileId) =>
            GoogleDriveApi.getMetadataById(fileId, field: 'modifiedTime')),
      ))
          .map((drive.File e) => e.modifiedTime)
          .whereType<DateTime>()
          .toList();
      final DateTime? lastBackupTime = timeList.isNotEmpty
          ? timeList.reduce((DateTime a, DateTime b) => a.isAfter(b) ? a : b)
          : null;

      if (!isClosed) {
        emit(BackupManagerGoogleDriveState(
          code: LoadingStateCode.loaded,
          libraryId: fileIdList[0],
          collectionId: fileIdList[1],
          bookmarkId: fileIdList[2],
          lastBackupTime: lastBackupTime,
        ));
      }
    } else if (!isClosed) {
      emit(const BackupManagerGoogleDriveState());
    }
  }

  /// Sets the backup enabled state and manages sign-in status.
  Future<void> setEnabled(bool isEnabled) async {
    final String key = PreferenceKeys.backupManager.isBackupToGoogleDrive;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isSignedIn = await GoogleDriveApi.isSignedIn();

    if (isEnabled != isSignedIn) {
      isEnabled
          ? await GoogleDriveApi.signIn()
          : await GoogleDriveApi.signOut();
    }

    await prefs.setBool(key, await GoogleDriveApi.isSignedIn());
  }

  /// Creates a backup and uploads it to Google Drive.
  Future<bool> backupAll() async {
    return false;
  }

  /// Deletes the existing backup from Google Drive.
  Future<bool> deleteAll() async {
    return false;
  }

  /// Restores a backup from Google Drive.
  Future<bool> restoreAll() async {
    return false;
  }

  @override
  Future<void> close() {
    _logger.close();
    return super.close();
  }
}
