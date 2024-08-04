import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:hive/hive.dart';
import 'package:path/path.dart';

import '../../../data/file_path.dart';
import '../../../processor/google_drive_api.dart';
import '../../../toolbox/random_utility.dart';

class BackupManagerGoogleDriveCubit extends Cubit<BackupManagerGoogleDriveState> {
  BackupManagerGoogleDriveCubit() : super(const BackupManagerGoogleDriveState());

  Future<void> init() async {
    await refresh();
  }

  Future<void> refresh() async {
    final Box box = Hive.box(name: 'settings');
    final bool isSignedIn = await GoogleDriveApi.instance.isSignedIn();
    final bool isEnabled = box.get('isBackupToGoogleDriveEnabled', defaultValue: false);
    emit(BackupManagerGoogleDriveState(isEnabled: isEnabled && isSignedIn));
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
    final File zipFile = File(join(tempFolder.path, 'Library_${DateTime.now().toIso8601String()}.zip'));
    zipFile.createSync();
    ZipFile.createFromDirectory(
      sourceDir: Directory(FilePath.instance.libraryRoot),
      zipFile: zipFile,
      recurseSubDirs: true,
    );

    final drive.File driveFile = drive.File();
    driveFile.name = 'Library_${DateTime.now().toIso8601String()}.zip';
    driveFile.parents = ['appDataFolder'];
    driveFile.mimeType = 'application/zip';

    /// Upload zip file.
    await GoogleDriveApi.instance.driveApi!.files.create(driveFile);

    tempFolder.deleteSync(recursive: true);

    if (!isClosed) {
      emit(state.copyWith(createState: BackupManagerGoogleDriveCreateState.success));

      await Future.delayed(const Duration(seconds: 1));

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
