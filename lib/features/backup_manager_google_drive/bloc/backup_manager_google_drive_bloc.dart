import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../processor/google_drive_api.dart';
import '../../../toolbox/backup_utility.dart';
import '../../../toolbox/random_utility.dart';

/// Manages Google Drive backup operations.
class BackupManagerGoogleDriveCubit
    extends Cubit<BackupManagerGoogleDriveState> {
  BackupManagerGoogleDriveCubit()
      : super(const BackupManagerGoogleDriveState());

  /// Initializes the backup manager by refreshing the state.
  Future<void> init() => refresh();

  /// Refreshes the backup state by checking preferences and updating metadata.
  Future<void> refresh() async {
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool('isBackupToGoogleDriveEnabled') ?? false;
    await setEnabled(isEnabled);

    if (state.code == BackupManagerGoogleDriveCode.idle) {
      final fileId = await GoogleDriveApi.instance.getFileId('Library.zip');
      if (fileId != null) {
        final metadata = await GoogleDriveApi.instance
            .getMetadataById(fileId, field: 'modifiedTime');
        emit(state.copyWith(fileId: fileId, metadata: metadata));
      }
    }
  }

  /// Sets the backup enabled state and manages sign-in status.
  Future<void> setEnabled(bool isEnabled) async {
    final isSignedIn = await GoogleDriveApi.instance.isSignedIn();

    if (isEnabled != isSignedIn) {
      isEnabled
          ? await GoogleDriveApi.instance.signIn()
          : await GoogleDriveApi.instance.signOut();
      isEnabled = await GoogleDriveApi.instance.isSignedIn();
    }

    emit(state.copyWith(
      code: isEnabled
          ? BackupManagerGoogleDriveCode.idle
          : BackupManagerGoogleDriveCode.disabled,
    ));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isBackupToGoogleDriveEnabled', isEnabled);
  }

  /// Creates a backup and uploads it to Google Drive.
  Future<bool> createBackup() async {
    final tempFolder = await RandomUtility.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    final zipFile = await BackupUtility.createBackup(tempFolder.path);
    await GoogleDriveApi.instance.uploadFile('appDataFolder', zipFile);

    tempFolder.deleteSync(recursive: true);
    return true;
  }

  /// Deletes the existing backup from Google Drive.
  Future<bool> deleteBackup() async {
    if (state.fileId == null) return false;

    await GoogleDriveApi.instance.deleteFile(state.fileId!);
    return true;
  }

  /// Restores a backup from Google Drive.
  Future<bool> restoreBackup() async {
    if (state.fileId == null) return false;

    final tempFolder = await RandomUtility.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    final zipFile = File(join(tempFolder.path, 'Library.zip'));
    zipFile.createSync();

    await GoogleDriveApi.instance.downloadFile(state.fileId!, zipFile);
    await BackupUtility.restoreBackup(tempFolder, zipFile);

    tempFolder.deleteSync(recursive: true);
    return true;
  }
}

/// Represents the state of the Google Drive backup manager.
class BackupManagerGoogleDriveState extends Equatable {
  final BackupManagerGoogleDriveCode code;
  final String? fileId;
  final drive.File? metadata;

  const BackupManagerGoogleDriveState({
    this.code = BackupManagerGoogleDriveCode.disabled,
    this.fileId,
    this.metadata,
  });

  @override
  List<Object?> get props => [code, fileId];

  /// Creates a copy of the current state with optional new values.
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

/// Enum representing the backup manager's operational state.
enum BackupManagerGoogleDriveCode { disabled, idle }
