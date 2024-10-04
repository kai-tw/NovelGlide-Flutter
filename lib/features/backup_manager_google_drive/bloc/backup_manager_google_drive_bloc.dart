import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../processor/google_drive_api.dart';
import '../../../toolbox/backup_utility.dart';
import '../../../toolbox/random_utility.dart';

class BackupManagerGoogleDriveCubit extends Cubit<BackupManagerGoogleDriveState> {
  BackupManagerGoogleDriveCubit() : super(const BackupManagerGoogleDriveState());

  Future<void> init() async => await refresh();

  Future<void> refresh() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isEnabled = prefs.getBool('isBackupToGoogleDriveEnabled') ?? false;
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

    emit(BackupManagerGoogleDriveState(
      code: isEnabled ? BackupManagerGoogleDriveCode.idle : BackupManagerGoogleDriveCode.disabled,
    ));

    // Save the setting.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isBackupToGoogleDriveEnabled', isEnabled);
  }

  Future<bool> createBackup() async {
    final Directory tempFolder = await RandomUtility.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    // Create zip file.
    final File zipFile = await BackupUtility.createBackup(tempFolder.path);

    // Upload zip file.
    await GoogleDriveApi.instance.uploadFile('appDataFolder', zipFile);

    tempFolder.deleteSync(recursive: true);

    return true;
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
