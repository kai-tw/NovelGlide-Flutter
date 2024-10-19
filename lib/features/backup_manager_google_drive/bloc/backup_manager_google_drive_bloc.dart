import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/bookmark_data.dart';
import '../../../data/collection_data.dart';
import '../../../data/preference_keys.dart';
import '../../../toolbox/google_drive_api.dart';
import '../../../toolbox/backup_utility.dart';
import '../../../toolbox/random_utility.dart';

/// Manages Google Drive backup operations.
class BackupManagerGoogleDriveCubit
    extends Cubit<BackupManagerGoogleDriveState> {
  final logger = Logger();
  final _drivePrefKey = PreferenceKeys.backupManager.isGoogleDriveEnabled;
  final _driveApi = GoogleDriveApi.instance;

  factory BackupManagerGoogleDriveCubit() {
    const initialState = BackupManagerGoogleDriveState();
    final cubit = BackupManagerGoogleDriveCubit._internal(initialState);
    cubit.refresh();
    return cubit;
  }

  BackupManagerGoogleDriveCubit._internal(super.initialState);

  /// Refreshes the backup state by checking preferences and updating metadata.
  Future<void> refresh() async {
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool(_drivePrefKey) ?? false;
    final isReady = await setEnabled(isEnabled);

    if (isReady) {
      // Get the ids of the files
      final libraryId =
          await _driveApi.getFileId(BackupUtility.libraryArchiveName);
      final collectionId =
          await _driveApi.getFileId(CollectionData.jsonFileName);
      final bookmarkId = await _driveApi.getFileId(BookmarkData.jsonFileName);
      final timeList = [
        libraryId != null
            ? (await _driveApi.getMetadataById(libraryId,
                    field: 'modifiedTime'))
                .modifiedTime
            : null,
        collectionId != null
            ? (await _driveApi.getMetadataById(collectionId,
                    field: 'modifiedTime'))
                .modifiedTime
            : null,
        bookmarkId != null
            ? (await _driveApi.getMetadataById(bookmarkId,
                    field: 'modifiedTime'))
                .modifiedTime
            : null,
      ].where((e) => e != null).toList();

      if (!isClosed) {
        emit(BackupManagerGoogleDriveState(
          isReady: isReady,
          libraryId: libraryId,
          collectionId: collectionId,
          bookmarkId: bookmarkId,
          lastBackupTime: timeList.isEmpty
              ? null
              : timeList.reduce((a, b) => a!.isAfter(b!) ? a : b),
        ));
      }
    } else if (!isClosed) {
      emit(const BackupManagerGoogleDriveState());
    }
  }

  /// Sets the backup enabled state and manages sign-in status.
  Future<bool> setEnabled(bool isEnabled) async {
    final isSignedIn = await _driveApi.isSignedIn();

    if (isEnabled != isSignedIn) {
      try {
        isEnabled ? await _driveApi.signIn() : await _driveApi.signOut();
      } catch (e) {
        logger.e(e);
      }
    }
    isEnabled = await _driveApi.isSignedIn();

    emit(state.copyWith(isReady: isEnabled));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_drivePrefKey, isEnabled);

    return isEnabled;
  }

  /// Creates a backup and uploads it to Google Drive.
  Future<bool> backupAll() async {
    return !(await Future.wait([
      backupLibrary(),
      backupCollections(),
      backupBookmarks(),
    ]))
        .contains(false);
  }

  /// Backs up the library to Google Drive.
  Future<bool> backupLibrary() async {
    final tempFolder = await RandomUtility.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);
    final zipFile = await BackupUtility.archiveLibrary(tempFolder.path);
    await _driveApi.uploadFile('appDataFolder', zipFile);
    tempFolder.deleteSync(recursive: true);
    return await _driveApi.fileExists(BackupUtility.libraryArchiveName);
  }

  Future<bool> backupCollections() async {
    final collectionFile = await CollectionData.jsonFile;
    if (collectionFile.existsSync()) {
      await _driveApi.uploadFile('appDataFolder', collectionFile);
    }
    return await _driveApi.fileExists(CollectionData.jsonFileName);
  }

  Future<bool> backupBookmarks() async {
    final bookmarkFile = await BookmarkData.jsonFile;
    if (bookmarkFile.existsSync()) {
      await _driveApi.uploadFile('appDataFolder', bookmarkFile);
    }
    return await _driveApi.fileExists(BookmarkData.jsonFileName);
  }

  /// Deletes the existing backup from Google Drive.
  Future<bool> deleteAll() async {
    return !(await Future.wait([
      deleteLibrary(),
      deleteCollections(),
      deleteBookmarks(),
    ]))
        .contains(false);
  }

  Future<bool> deleteLibrary() async {
    if (state.libraryId != null) {
      await _driveApi.deleteFile(state.libraryId!);
    }
    return !(await _driveApi.fileExists(BackupUtility.libraryArchiveName));
  }

  Future<bool> deleteCollections() async {
    final collectionFileId =
        await _driveApi.getFileId(CollectionData.jsonFileName);
    if (collectionFileId != null) {
      await _driveApi.deleteFile(collectionFileId);
    }
    return !(await _driveApi.fileExists(CollectionData.jsonFileName));
  }

  Future<bool> deleteBookmarks() async {
    final bookmarkFileId = await _driveApi.getFileId(BookmarkData.jsonFileName);
    if (bookmarkFileId != null) {
      await _driveApi.deleteFile(bookmarkFileId);
    }
    return !(await _driveApi.fileExists(BookmarkData.jsonFileName));
  }

  /// Restores a backup from Google Drive.
  Future<bool> restoreAll() async {
    await Future.wait([
      restoreLibrary(),
      restoreCollections(),
      restoreBookmarks(),
    ]);
    return true;
  }

  Future<bool> restoreLibrary() async {
    if (state.libraryId != null) {
      final tempFolder = await RandomUtility.getAvailableTempFolder();
      tempFolder.createSync(recursive: true);

      final zipFile = File(
        join(
          tempFolder.path,
          BackupUtility.libraryArchiveName,
        ),
      );
      zipFile.createSync();

      // Restore books
      await _driveApi.downloadFile(state.libraryId!, zipFile);
      await BackupUtility.restoreBackup(tempFolder, zipFile);

      tempFolder.deleteSync(recursive: true);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> restoreCollections() async {
    final id = await _driveApi.getFileId(CollectionData.jsonFileName);
    if (id != null) {
      await _driveApi.downloadFile(id, await CollectionData.jsonFile);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> restoreBookmarks() async {
    final id = await _driveApi.getFileId(BookmarkData.jsonFileName);
    if (id != null) {
      await _driveApi.downloadFile(id, await BookmarkData.jsonFile);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> close() {
    logger.close();
    return super.close();
  }
}

/// Represents the state of the Google Drive backup manager.
class BackupManagerGoogleDriveState extends Equatable {
  final bool isReady;
  final String? libraryId;
  final String? collectionId;
  final String? bookmarkId;
  final DateTime? lastBackupTime;

  const BackupManagerGoogleDriveState({
    this.isReady = false,
    this.libraryId,
    this.collectionId,
    this.bookmarkId,
    this.lastBackupTime,
  });

  @override
  List<Object?> get props => [
        isReady,
        libraryId,
        collectionId,
        bookmarkId,
        lastBackupTime,
      ];

  /// Creates a copy of the current state with optional new values.
  BackupManagerGoogleDriveState copyWith({
    bool? isReady,
    String? libraryId,
    String? collectionId,
    String? bookmarkId,
    DateTime? lastBackupTime,
  }) {
    return BackupManagerGoogleDriveState(
      isReady: isReady ?? this.isReady,
      libraryId: libraryId ?? this.libraryId,
      collectionId: collectionId ?? this.collectionId,
      bookmarkId: bookmarkId ?? this.bookmarkId,
      lastBackupTime: lastBackupTime ?? this.lastBackupTime,
    );
  }
}
