import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart';
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
    await setEnabled(isEnabled);

    if (state.code == BackupManagerGoogleDriveCode.idle) {
      final String? fileId = await GoogleDriveApi.instance.getFileId('Library.zip');

      if (fileId != null) {
        final drive.File metadata = await GoogleDriveApi.instance.getMetadataById(fileId, field: 'modifiedTime');
        emit(state.copyWith(fileId: fileId, metadata: metadata));
      }
    }
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

  Future<bool> deleteBackup() async {
    if (state.fileId == null) {
      return false;
    }

    await GoogleDriveApi.instance.deleteFile(state.fileId!);
    return true;
  }

  Future<bool> restoreBackup() async {
    if (state.fileId == null) {
      return false;
    }

    final Directory tempFolder = await RandomUtility.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    final File zipFile = File(join(tempFolder.path, 'Library.zip'));
    zipFile.createSync();

    await GoogleDriveApi.instance.downloadFile(state.fileId!, zipFile);

    await BackupUtility.restoreBackup(tempFolder, zipFile);

    tempFolder.deleteSync(recursive: true);
    return true;
  }
}

class BackupManagerGoogleDriveState extends Equatable {
  final BackupManagerGoogleDriveCode code;
  final String? fileId;
  final drive.File? metadata;

  @override
  List<Object?> get props => [code, fileId];

  const BackupManagerGoogleDriveState({
    this.code = BackupManagerGoogleDriveCode.disabled,
    this.fileId,
    this.metadata,
  });

  BackupManagerGoogleDriveState copyWith({
    BackupManagerGoogleDriveCode? code,
    String? fileId,
    drive.File? metadata,
  }) {
    return BackupManagerGoogleDriveState(
      code: code ?? this.code,
      fileId: fileId ?? this.fileId,
      metadata: metadata ?? this.metadata,
    );
  }
}

enum BackupManagerGoogleDriveCode { disabled, idle }
