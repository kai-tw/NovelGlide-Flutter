import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../enum/loading_state_code.dart';
import '../../../../../core/services/preference_service/preference_service.dart';
import '../../../../auth/domain/entities/auth_providers.dart';
import '../../../../auth/domain/use_cases/auth_is_sign_in_use_case.dart';
import '../../../../auth/domain/use_cases/auth_sign_in_use_case.dart';
import '../../../../auth/domain/use_cases/auth_sign_out_use_case.dart';
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
    this._isSignInUseCase,
    this._signInUseCase,
    this._signOutUseCase,
  ) : super(const BackupServiceGoogleDriveState());

  /// Backup use cases.
  final BackupGetBookBackupExistsUseCase _getBookBackupExistsUseCase;
  final BackupGetBookmarkBackupExistsUseCase _getBookmarkBackupExistsUseCase;
  final BackupGetCollectionBackupExistsUseCase
      _getCollectionBackupExistsUseCase;
  final BackupGetLastBackupTimeUseCase _getLastBackupTimeUseCase;

  /// Auth use cases.
  final AuthIsSignInUseCase _isSignInUseCase;
  final AuthSignInUseCase _signInUseCase;
  final AuthSignOutUseCase _signOutUseCase;

  /// Auth provider
  final AuthProviders _provider = AuthProviders.google;

  /// Refreshes the backup state by checking preferences and updating metadata.
  Future<void> refresh() async {
    emit(const BackupServiceGoogleDriveState(code: LoadingStateCode.loading));

    // Load preferences.
    final BackupPreferenceData data = await PreferenceService.backup.load();
    final bool isEnabled = data.isGoogleDriveEnabled;

    if (isEnabled && !await _isSignInUseCase(_provider)) {
      try {
        await _signInUseCase(_provider);
      } catch (_) {}
    }

    if (await _isSignInUseCase(_provider)) {
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
    final bool isSignedIn = await _isSignInUseCase(_provider);

    if (isEnabled != isSignedIn) {
      isEnabled
          ? await _signInUseCase(_provider)
          : await _signOutUseCase(_provider);

      await PreferenceService.backup.save(BackupPreferenceData(
        isGoogleDriveEnabled: await _isSignInUseCase(_provider),
      ));

      refresh();
    }
  }
}
