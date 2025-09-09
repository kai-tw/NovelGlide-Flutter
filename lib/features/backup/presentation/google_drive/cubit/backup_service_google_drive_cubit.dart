import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../enum/loading_state_code.dart';
import '../../../../auth/domain/entities/auth_providers.dart';
import '../../../../auth/domain/use_cases/auth_is_sign_in_use_case.dart';
import '../../../../auth/domain/use_cases/auth_sign_in_use_case.dart';
import '../../../../auth/domain/use_cases/auth_sign_out_use_case.dart';
import '../../../../preference/domain/entities/backup_preference_data.dart';
import '../../../../preference/domain/use_cases/preference_get_use_cases.dart';
import '../../../../preference/domain/use_cases/preference_observe_change_use_case.dart';
import '../../../../preference/domain/use_cases/preference_save_use_case.dart';
import '../../../domain/use_cases/backup_get_book_backup_exists_use_case.dart';
import '../../../domain/use_cases/backup_get_bookmark_backup_exists_use_case.dart';
import '../../../domain/use_cases/backup_get_collection_backup_exists_use_case.dart';
import '../../../domain/use_cases/backup_get_last_backup_time_use_case.dart';

part 'backup_service_google_drive_state.dart';

/// Manages Google Drive backup operations.
class BackupServiceGoogleDriveCubit
    extends Cubit<BackupServiceGoogleDriveState> {
  factory BackupServiceGoogleDriveCubit(
    BackupGetBookBackupExistsUseCase getBookBackupExistsUseCase,
    BackupGetBookmarkBackupExistsUseCase getBookmarkBackupExistsUseCase,
    BackupGetCollectionBackupExistsUseCase getCollectionBackupExistsUseCase,
    BackupGetLastBackupTimeUseCase getLastBackupTimeUseCase,
    AuthIsSignInUseCase isSignInUseCase,
    AuthSignInUseCase signInUseCase,
    AuthSignOutUseCase signOutUseCase,
    BackupGetPreferenceUseCase getPreferenceUseCase,
    BackupSavePreferenceUseCase savePreferenceUseCase,
    BackupObservePreferenceChangeUseCase observePreferenceChangeUseCase,
  ) {
    final BackupServiceGoogleDriveCubit instance =
        BackupServiceGoogleDriveCubit._(
      getBookBackupExistsUseCase,
      getBookmarkBackupExistsUseCase,
      getCollectionBackupExistsUseCase,
      getLastBackupTimeUseCase,
      isSignInUseCase,
      signInUseCase,
      signOutUseCase,
      getPreferenceUseCase,
      savePreferenceUseCase,
    );

    instance._preferenceSubscription = observePreferenceChangeUseCase()
        .listen((BackupPreferenceData data) => instance.refresh());

    return instance;
  }

  BackupServiceGoogleDriveCubit._(
    this._getBookBackupExistsUseCase,
    this._getBookmarkBackupExistsUseCase,
    this._getCollectionBackupExistsUseCase,
    this._getLastBackupTimeUseCase,
    this._isSignInUseCase,
    this._signInUseCase,
    this._signOutUseCase,
    this._getPreferenceUseCase,
    this._savePreferenceUseCase,
  ) : super(const BackupServiceGoogleDriveState());

  /// Stream subscriptions
  late final StreamSubscription<BackupPreferenceData> _preferenceSubscription;

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

  /// Preferences use cases.
  final BackupGetPreferenceUseCase _getPreferenceUseCase;
  final BackupSavePreferenceUseCase _savePreferenceUseCase;

  /// Auth provider
  final AuthProviders _provider = AuthProviders.google;

  /// Refreshes the backup state by checking preferences and updating metadata.
  Future<void> refresh() async {
    emit(const BackupServiceGoogleDriveState(code: LoadingStateCode.loading));

    // Load preferences.
    final BackupPreferenceData data = await _getPreferenceUseCase();
    final bool isEnabled = data.isGoogleDriveEnabled;

    if (isEnabled && !await _isSignInUseCase(_provider)) {
      try {
        await _signInUseCase(_provider);
      } catch (_) {}
    }

    if (await _isSignInUseCase(_provider)) {
      final bool isBookmarkBackupExists =
          await _getBookmarkBackupExistsUseCase();
      final bool isBookBackupExists = await _getBookBackupExistsUseCase();
      final bool isCollectionBackupExists =
          await _getCollectionBackupExistsUseCase();
      final DateTime? lastBackupTime = await _getLastBackupTimeUseCase();

      if (!isClosed) {
        emit(BackupServiceGoogleDriveState(
          code: LoadingStateCode.loaded,
          isBookBackupExists: isBookBackupExists,
          isBookmarkBackupExists: isBookmarkBackupExists,
          isCollectionBackupExists: isCollectionBackupExists,
          lastBackupTime: lastBackupTime,
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

      await _savePreferenceUseCase(BackupPreferenceData(
        isGoogleDriveEnabled: await _isSignInUseCase(_provider),
      ));

      refresh();
    }
  }

  @override
  Future<void> close() async {
    await _preferenceSubscription.cancel();
    return super.close();
  }
}
