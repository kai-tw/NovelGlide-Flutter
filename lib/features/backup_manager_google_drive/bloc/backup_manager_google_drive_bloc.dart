import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../processor/google_drive_api.dart';
import '../../../toolbox/backup_utility.dart';
import '../../../toolbox/random_utility.dart';

class BackupManagerGoogleDriveCubit extends Cubit<BackupManagerGoogleDriveState> {
  BackupManagerGoogleDriveCubit() : super(const BackupManagerGoogleDriveState());

  Future<void> init() async => await refresh();

  Future<void> refresh() async {
    final Box box = Hive.box(name: 'settings');
    final bool isEnabled = box.get('isBackupToGoogleDriveEnabled', defaultValue: false);
    box.close();
    setEnabled(isEnabled);
  }

  Future<void> setEnabled(bool isEnabled) async {
    final bool isSignedIn = await GoogleDriveApi.instance.isSignedIn();

    if (isEnabled && !isSignedIn) {
      // If the user is not signed in, sign in.
      await GoogleDriveApi.instance.signIn();
      isEnabled = await GoogleDriveApi.instance.isSignedIn();
    } else if (!isEnabled && isSignedIn) {
      // If the user is signed in, sign out.
      await GoogleDriveApi.instance.signOut();
    }

    // Save the setting.
    final Box box = Hive.box(name: 'settings');
    box.put('isBackupToGoogleDriveEnabled', isEnabled);
    box.close();

    emit(BackupManagerGoogleDriveState(
      code: isEnabled ? BackupManagerGoogleDriveCode.idle : BackupManagerGoogleDriveCode.disabled,
    ));
  }

  Future<void> createBackup() async {
    emit(state.copyWith(code: BackupManagerGoogleDriveCode.creating));
    final Directory tempFolder = await RandomUtility.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    // Create zip file.
    final File zipFile = await BackupUtility.createBackup(tempFolder.path);

    // Upload zip file.
    await GoogleDriveApi.instance.uploadFile('appDataFolder', zipFile);

    tempFolder.deleteSync(recursive: true);

    if (!isClosed) {
      emit(state.copyWith(code: BackupManagerGoogleDriveCode.success));
    }

    await Future.delayed(const Duration(seconds: 2));

    if (!isClosed) {
      emit(state.copyWith(code: BackupManagerGoogleDriveCode.idle));
    }
  }
}

class BackupManagerGoogleDriveState extends Equatable {
  final BackupManagerGoogleDriveCode code;

  @override
  List<Object?> get props => [code];

  const BackupManagerGoogleDriveState({
    this.code = BackupManagerGoogleDriveCode.disabled,
  });

  BackupManagerGoogleDriveState copyWith({
    BackupManagerGoogleDriveCode? code,
  }) {
    return BackupManagerGoogleDriveState(
      code: code ?? this.code,
    );
  }
}

enum BackupManagerGoogleDriveCode { disabled, idle, creating, success, error }
