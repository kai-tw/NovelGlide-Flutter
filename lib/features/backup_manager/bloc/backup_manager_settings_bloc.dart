import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/preference_keys.dart';

class BackupManagerSettingsCubit extends Cubit<BackupManagerSettingsState> {
  BackupManagerSettingsCubit() : super(const BackupManagerSettingsState());

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isBackupCollections = prefs.getBool(PreferenceKeys.backupManager.isBackupCollections) ?? false;
    final isBackupBookmarks = prefs.getBool(PreferenceKeys.backupManager.isBackupBookmarks) ?? false;

    emit(state.copyWith(
      isBackupCollections: isBackupCollections,
      isBackupBookmarks: isBackupBookmarks,
    ));
  }

  Future<void> setState({bool? backupCollections, bool? backupBookmarks}) async {
    final isBackupCollections = backupCollections ?? state.isBackupCollections;
    final isBackupBookmarks = backupBookmarks ?? state.isBackupBookmarks;

    emit(state.copyWith(
      isBackupCollections: isBackupCollections,
      isBackupBookmarks: isBackupBookmarks,
    ));

    // Save the settings
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PreferenceKeys.backupManager.isBackupCollections, isBackupCollections);
    prefs.setBool(PreferenceKeys.backupManager.isBackupBookmarks, isBackupBookmarks);
  }
}

class BackupManagerSettingsState extends Equatable {
  final bool isBackupCollections;
  final bool isBackupBookmarks;

  @override
  List<Object?> get props => [isBackupCollections, isBackupBookmarks];

  const BackupManagerSettingsState({
    this.isBackupCollections = false,
    this.isBackupBookmarks = false,
  });

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