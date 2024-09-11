import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class BackupManagerSettingsCubit extends Cubit<BackupManagerSettingsState> {
  BackupManagerSettingsCubit() : super(const BackupManagerSettingsState());

  void init() {
    final Box box = Hive.box(name: 'settings');
    final isBackupCollections = box.get('backupManager.isBackupCollections', defaultValue: false);
    final isBackupBookmarks = box.get('backupManager.isBackupBookmarks', defaultValue: false);
    box.close();

    emit(state.copyWith(
      isBackupCollections: isBackupCollections,
      isBackupBookmarks: isBackupBookmarks,
    ));
  }

  void setState({bool? backupCollections, bool? backupBookmarks}) {
    final isBackupCollections = backupCollections ?? state.isBackupCollections;
    final isBackupBookmarks = backupBookmarks ?? state.isBackupBookmarks;

    // Save the settings
    final Box box = Hive.box(name: 'settings');
    box.put('backupManager.isBackupCollections', isBackupCollections);
    box.put('backupManager.isBackupBookmarks', isBackupBookmarks);
    box.close();

    emit(state.copyWith(
      isBackupCollections: isBackupCollections,
      isBackupBookmarks: isBackupBookmarks,
    ));
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