import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../processor/google_drive_api.dart';
import '../../../toolbox/backup_utility.dart';
import '../../../toolbox/random_utility.dart';

class BackupManagerGoogleDriveCubit extends Cubit<BackupManagerGoogleDriveState> {
  BackupManagerGoogleDriveCubit() : super(const BackupManagerGoogleDriveState());

  Future<void> init() async {
    await refresh();
  }

  Future<void> refresh() async {
    final Box box = Hive.box(name: 'settings');
    final bool isEnabled = box.get('isBackupToGoogleDriveEnabled', defaultValue: false);
    if (isEnabled && !await GoogleDriveApi.instance.isSignedIn()) {
      await GoogleDriveApi.instance.signIn();
    }
    emit(BackupManagerGoogleDriveState(isEnabled: isEnabled && await GoogleDriveApi.instance.isSignedIn()));
    box.close();
  }

  Future<void> setEnabled(bool isEnabled) async {
    final Box box = Hive.box(name: 'settings');
    if (isEnabled) {
      try {
        await GoogleDriveApi.instance.signIn();
      } catch (e) {
        isEnabled = false;
      }
    } else {
      await GoogleDriveApi.instance.signOut();
    }
    box.put('isBackupToGoogleDriveEnabled', isEnabled);
    box.close();
    refresh();
  }

  Future<void> createBackup() async {
    emit(state.copyWith(createState: BackupManagerGoogleDriveCreateState.creating));
    final Directory tempFolder = RandomUtility.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    /// Create zip file.
    final File zipFile = await BackupUtility.createBackup(tempFolder.path);

    /// Upload zip file.
    await GoogleDriveApi.instance.uploadFile('appDataFolder', zipFile);

    tempFolder.deleteSync(recursive: true);

    if (!isClosed) {
      emit(state.copyWith(createState: BackupManagerGoogleDriveCreateState.success));

      await Future.delayed(const Duration(seconds: 2));

      if (!isClosed) {
        refresh();
      }
    }
  }
}

class BackupManagerGoogleDriveState extends Equatable {
  final bool isEnabled;
  final BackupManagerGoogleDriveCreateState createState;

  @override
  List<Object?> get props => [
        isEnabled,
        createState,
      ];

  const BackupManagerGoogleDriveState({
    this.isEnabled = false,
    this.createState = BackupManagerGoogleDriveCreateState.idle,
  });

  BackupManagerGoogleDriveState copyWith({
    bool? isEnabled,
    BackupManagerGoogleDriveCreateState? createState,
  }) {
    return BackupManagerGoogleDriveState(
      isEnabled: isEnabled ?? this.isEnabled,
      createState: createState ?? this.createState,
    );
  }
}

enum BackupManagerGoogleDriveCreateState { idle, creating, success, failed }
