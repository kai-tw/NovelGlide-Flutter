import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart' as drive;

import '../../../../../../enum/loading_state_code.dart';
import '../../../../../core/interfaces/google_api_interfaces/google_api_interfaces.dart';
import '../../../../../core/services/preference_service/preference_service.dart';
import '../../../../bookmark/bookmark_service.dart';
import '../../../../collection/collection_service.dart';
import '../../../backup_service.dart';

part 'backup_service_google_drive_state.dart';

/// Manages Google Drive backup operations.
class BackupServiceGoogleDriveCubit
    extends Cubit<BackupServiceGoogleDriveState> {
  factory BackupServiceGoogleDriveCubit() {
    final BackupServiceGoogleDriveCubit cubit =
        BackupServiceGoogleDriveCubit._();
    cubit.refresh();
    return cubit;
  }

  BackupServiceGoogleDriveCubit._()
      : super(const BackupServiceGoogleDriveState());

  /// Refreshes the backup state by checking preferences and updating metadata.
  Future<void> refresh() async {
    emit(const BackupServiceGoogleDriveState(code: LoadingStateCode.loading));

    // Load preferences.
    final BackupPreferenceData data = await PreferenceService.backup.load();
    final bool isEnabled = data.isGoogleDriveEnabled;

    if (isEnabled && !GoogleApiInterfaces.drive.isSignedIn) {
      try {
        await GoogleApiInterfaces.drive.signIn();
      } catch (_) {}
    }

    if (GoogleApiInterfaces.drive.isSignedIn) {
      // Load the file IDs.
      final List<String> fileNameList =
          await Future.wait<String>(<Future<String>>[
        BackupService.bookRepository.fileName,
        CollectionService.repository.jsonFileName,
        BookmarkService.repository.jsonFileName,
      ]);
      final List<String?> fileIdList = await Future.wait<String?>(
        fileNameList.map(
            (String fileName) => GoogleApiInterfaces.drive.getFileId(fileName)),
      );

      // Get the last backup time.
      final List<DateTime> timeList = (await Future.wait<drive.File>(
        fileIdList.whereType<String>().map((String fileId) =>
            GoogleApiInterfaces.drive
                .getMetadataById(fileId, field: 'modifiedTime')),
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
    final bool isSignedIn = GoogleApiInterfaces.drive.isSignedIn;

    if (isEnabled != isSignedIn) {
      isEnabled
          ? await GoogleApiInterfaces.drive.signIn()
          : await GoogleApiInterfaces.drive.signOut();
    }

    await PreferenceService.backup.save(BackupPreferenceData(
      isGoogleDriveEnabled: GoogleApiInterfaces.drive.isSignedIn,
    ));
  }
}
