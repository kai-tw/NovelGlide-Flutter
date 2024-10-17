import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/preference_keys.dart';

/// Manages the state of backup settings using a Cubit.
class BackupManagerSettingsCubit extends Cubit<BackupManagerSettingsState> {
  final _collectionPrefKey = PreferenceKeys.backupManager.isBackupCollections;
  final _bookmarkPrefKey = PreferenceKeys.backupManager.isBackupBookmarks;

  factory BackupManagerSettingsCubit() => BackupManagerSettingsCubit._internal(
        const BackupManagerSettingsState(),
      ).._init();

  BackupManagerSettingsCubit._internal(super.initialState);

  /// Initializes the backup settings from shared preferences.
  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final isBackupCollections = prefs.getBool(_collectionPrefKey) ?? false;
    final isBackupBookmarks = prefs.getBool(_bookmarkPrefKey) ?? false;

    if (!isClosed) {
      emit(
        state.copyWith(
          isBackupCollections: isBackupCollections,
          isBackupBookmarks: isBackupBookmarks,
        ),
      );
    }
  }

  /// Updates the backup settings and saves them to shared preferences.
  Future<void> setState({
    bool? isBackupCollections,
    bool? isBackupBookmarks,
  }) async {
    isBackupCollections = isBackupCollections ?? state.isBackupCollections;
    isBackupBookmarks = isBackupBookmarks ?? state.isBackupBookmarks;

    if (!isClosed) {
      emit(
        state.copyWith(
          isBackupCollections: isBackupCollections,
          isBackupBookmarks: isBackupBookmarks,
        ),
      );

      final prefs = await SharedPreferences.getInstance();
      prefs.setBool(_collectionPrefKey, isBackupCollections);
      prefs.setBool(_bookmarkPrefKey, isBackupBookmarks);
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
