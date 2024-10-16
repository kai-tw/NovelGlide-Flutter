import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/preference_keys.dart';

/// Manages the state of backup settings using a Cubit.
class BackupManagerSettingsCubit extends Cubit<BackupManagerSettingsState> {
  BackupManagerSettingsCubit() : super(const BackupManagerSettingsState());

  /// Initializes the backup settings from shared preferences.
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final isBackupCollections =
        prefs.getBool(PreferenceKeys.backupManager.isBackupCollections) ??
            false;
    final isBackupBookmarks =
        prefs.getBool(PreferenceKeys.backupManager.isBackupBookmarks) ?? false;

    if (isBackupCollections != state.isBackupCollections ||
        isBackupBookmarks != state.isBackupBookmarks) {
      emit(
        state.copyWith(
          isBackupCollections: isBackupCollections,
          isBackupBookmarks: isBackupBookmarks,
        ),
      );
    }
  }

  /// Updates the backup settings and saves them to shared preferences.
  Future<void> setState(
      {bool? backupCollections, bool? backupBookmarks}) async {
    final isBackupCollections = backupCollections ?? state.isBackupCollections;
    final isBackupBookmarks = backupBookmarks ?? state.isBackupBookmarks;

    if (isBackupCollections != state.isBackupCollections ||
        isBackupBookmarks != state.isBackupBookmarks) {
      emit(
        state.copyWith(
          isBackupCollections: isBackupCollections,
          isBackupBookmarks: isBackupBookmarks,
        ),
      );

      final prefs = await SharedPreferences.getInstance();
      prefs.setBool(PreferenceKeys.backupManager.isBackupCollections,
          isBackupCollections);
      prefs.setBool(
          PreferenceKeys.backupManager.isBackupBookmarks, isBackupBookmarks);
    }
  }
}

/// Represents the state of backup settings.
class BackupManagerSettingsState extends Equatable {
  final bool isBackupCollections;
  final bool isBackupBookmarks;

  @override
  List<Object?> get props => [isBackupCollections, isBackupBookmarks];

  const BackupManagerSettingsState({
    this.isBackupCollections = false,
    this.isBackupBookmarks = false,
  });

  /// Creates a copy of the current state with optional new values.
  BackupManagerSettingsState copyWith({
    bool? isBackupCollections,
    bool? isBackupBookmarks,
  }) {
    return BackupManagerSettingsState(
      isBackupCollections: isBackupCollections ?? this.isBackupCollections,
      isBackupBookmarks: isBackupBookmarks ?? this.isBackupBookmarks,
    );
  }
}
