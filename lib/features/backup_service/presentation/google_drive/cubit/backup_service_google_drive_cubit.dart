import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../enum/loading_state_code.dart';
import '../../../../../core/interfaces/google_api_interfaces/google_api_interfaces.dart';
import '../../../../../core/services/preference_service/preference_service.dart';
import '../../../domain/use_cases/backup_get_book_backup_exists_use_case.dart';
import '../../../domain/use_cases/backup_get_bookmark_backup_exists_use_case.dart';
import '../../../domain/use_cases/backup_get_collection_backup_exists_use_case.dart';
import '../../../domain/use_cases/backup_get_last_backup_time_use_case.dart';

part 'backup_service_google_drive_state.dart';

/// Manages Google Drive backup operations.
class BackupServiceGoogleDriveCubit
    extends Cubit<BackupServiceGoogleDriveState> {
  BackupServiceGoogleDriveCubit(
    this._getBookBackupExistsUseCase,
    this._getBookmarkBackupExistsUseCase,
    this._getCollectionBackupExistsUseCase,
    this._getLastBackupTimeUseCase,
  ) : super(const BackupServiceGoogleDriveState());

  final BackupGetBookBackupExistsUseCase _getBookBackupExistsUseCase;
  final BackupGetBookmarkBackupExistsUseCase _getBookmarkBackupExistsUseCase;
  final BackupGetCollectionBackupExistsUseCase
      _getCollectionBackupExistsUseCase;
  final BackupGetLastBackupTimeUseCase _getLastBackupTimeUseCase;

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
      if (!isClosed) {
        emit(BackupServiceGoogleDriveState(
          code: LoadingStateCode.loaded,
          isBookBackupExists: await _getBookBackupExistsUseCase(),
          isBookmarkBackupExists: await _getBookmarkBackupExistsUseCase(),
          isCollectionBackupExists: await _getCollectionBackupExistsUseCase(),
          lastBackupTime: await _getLastBackupTimeUseCase(),
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

      await PreferenceService.backup.save(BackupPreferenceData(
        isGoogleDriveEnabled: GoogleApiInterfaces.drive.isSignedIn,
      ));

      refresh();
    }
  }
}
