part of '../backup_manager_google_drive.dart';

/// Manages Google Drive backup operations.
class _Cubit extends Cubit<_State> {
  final _logger = Logger();
  final _drivePrefKey = PreferenceKeys.backupManager.isGoogleDriveEnabled;
  final _driveApi = GoogleDriveApi.instance;

  factory _Cubit() {
    const initialState = _State();
    final cubit = _Cubit._internal(initialState);
    cubit.refresh();
    return cubit;
  }

  _Cubit._internal(super.initialState);

  /// Refreshes the backup state by checking preferences and updating metadata.
  Future<void> refresh() async {
    emit(
      const _State(
        code: LoadingStateCode.loading,
      ),
    );
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool(_drivePrefKey) ?? false;
    final isReady = await _isApiReady(isEnabled);

    if (isReady) {
      final fileNameList = [
        BackupUtils.libraryArchiveName,
        CollectionRepository.jsonFileName,
        BookmarkRepository.jsonFileName,
      ];
      final fileIdList = await Future.wait(
        fileNameList.map((fileName) => _driveApi.getFileId(fileName)),
      );
      final timeList = (await Future.wait(
        fileIdList.whereType<String>().map((fileId) =>
            _driveApi.getMetadataById(fileId, field: 'modifiedTime')),
      ))
          .map((e) => e.modifiedTime)
          .toList();

      if (!isClosed) {
        emit(_State(
          code: LoadingStateCode.loaded,
          libraryId: fileIdList[0],
          collectionId: fileIdList[1],
          bookmarkId: fileIdList[2],
          lastBackupTime: timeList.reduce(
              (a, b) => a?.isAfter(b ?? DateTime.utc(0)) ?? false ? a : b),
        ));
      }
    } else if (!isClosed) {
      emit(const _State());
    }
  }

  /// Sets the backup enabled state and manages sign-in status.
  Future<void> setEnabled(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_drivePrefKey, await _isApiReady(isEnabled));
  }

  /// Checks if the Google Drive is ready to be used.
  Future<bool> _isApiReady(bool isEnabled) async {
    final isSignedIn = await _driveApi.isSignedIn();

    if (isEnabled != isSignedIn) {
      isEnabled ? await _driveApi.signIn() : await _driveApi.signOut();
    }
    return _driveApi.isSignedIn();
  }

  /// Creates a backup and uploads it to Google Drive.
  Future<bool> backupAll() async {
    final result = !(await Future.wait([
      backupLibrary(),
      backupCollections(),
      backupBookmarks(),
    ]))
        .contains(false);
    refresh();
    return result;
  }

  /// Back up the library to Google Drive.
  Future<bool> backupLibrary() async {
    final tempFolder = RandomUtils.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);
    final zipFile = await BackupUtils.archiveLibrary(tempFolder.path);
    await _driveApi.uploadFile('appDataFolder', zipFile);
    tempFolder.deleteSync(recursive: true);
    final result = await _driveApi.fileExists(BackupUtils.libraryArchiveName);
    refresh();
    return result;
  }

  Future<bool> backupCollections() async {
    final collectionFile = CollectionRepository.jsonFile;
    if (collectionFile.existsSync()) {
      await _driveApi.uploadFile('appDataFolder', collectionFile);
    }
    final result =
        await _driveApi.fileExists(CollectionRepository.jsonFileName);
    refresh();
    return result;
  }

  Future<bool> backupBookmarks() async {
    final bookmarkFile = BookmarkRepository.jsonFile;
    if (bookmarkFile.existsSync()) {
      await _driveApi.uploadFile('appDataFolder', bookmarkFile);
    }
    final result = await _driveApi.fileExists(BookmarkRepository.jsonFileName);
    refresh();
    return result;
  }

  /// Deletes the existing backup from Google Drive.
  Future<bool> deleteAll() async {
    final result = !(await Future.wait([
      deleteLibrary(),
      deleteCollections(),
      deleteBookmarks(),
    ]))
        .contains(false);
    refresh();
    return result;
  }

  Future<bool> deleteLibrary() async {
    if (state.libraryId != null) {
      await _driveApi.deleteFile(state.libraryId!);
    }
    final result =
        !(await _driveApi.fileExists(BackupUtils.libraryArchiveName));
    refresh();
    return result;
  }

  Future<bool> deleteCollections() async {
    final collectionFileId =
        await _driveApi.getFileId(CollectionRepository.jsonFileName);
    if (collectionFileId != null) {
      await _driveApi.deleteFile(collectionFileId);
    }
    final result =
        !(await _driveApi.fileExists(CollectionRepository.jsonFileName));
    refresh();
    return result;
  }

  Future<bool> deleteBookmarks() async {
    final bookmarkFileId =
        await _driveApi.getFileId(BookmarkRepository.jsonFileName);
    if (bookmarkFileId != null) {
      await _driveApi.deleteFile(bookmarkFileId);
    }
    final result =
        !(await _driveApi.fileExists(BookmarkRepository.jsonFileName));
    refresh();
    return result;
  }

  /// Restores a backup from Google Drive.
  Future<bool> restoreAll() async {
    await Future.wait([
      restoreLibrary(),
      restoreCollections(),
      restoreBookmarks(),
    ]);
    refresh();
    return true;
  }

  Future<bool> restoreLibrary() async {
    if (state.libraryId != null) {
      final tempFolder = RandomUtils.getAvailableTempFolder();
      tempFolder.createSync(recursive: true);

      final zipFile = File(
        join(
          tempFolder.path,
          BackupUtils.libraryArchiveName,
        ),
      );
      zipFile.createSync();

      // Restore books
      await _driveApi.downloadFile(state.libraryId!, zipFile);
      await BackupUtils.restoreBackup(tempFolder, zipFile);

      tempFolder.deleteSync(recursive: true);
    }
    refresh();
    return state.libraryId != null;
  }

  Future<bool> restoreCollections() async {
    final id = await _driveApi.getFileId(CollectionRepository.jsonFileName);
    if (id != null) {
      await _driveApi.downloadFile(id, CollectionRepository.jsonFile);
    }
    refresh();
    return id != null;
  }

  Future<bool> restoreBookmarks() async {
    final id = await _driveApi.getFileId(BookmarkRepository.jsonFileName);
    if (id != null) {
      await _driveApi.downloadFile(id, BookmarkRepository.jsonFile);
    }
    refresh();
    return id != null;
  }

  @override
  Future<void> close() {
    _logger.close();
    return super.close();
  }
}

/// Represents the state of the Google Drive backup manager.
class _State extends Equatable {
  final LoadingStateCode code;
  final String? libraryId;
  final String? collectionId;
  final String? bookmarkId;
  final DateTime? lastBackupTime;

  const _State({
    this.code = LoadingStateCode.initial,
    this.libraryId,
    this.collectionId,
    this.bookmarkId,
    this.lastBackupTime,
  });

  @override
  List<Object?> get props => [
        code,
        libraryId,
        collectionId,
        bookmarkId,
        lastBackupTime,
      ];

  /// Creates a copy of the current state with optional new values.
  _State copyWith({
    LoadingStateCode? code,
    String? libraryId,
    String? collectionId,
    String? bookmarkId,
    DateTime? lastBackupTime,
  }) {
    return _State(
      code: code ?? this.code,
      libraryId: libraryId ?? this.libraryId,
      collectionId: collectionId ?? this.collectionId,
      bookmarkId: bookmarkId ?? this.bookmarkId,
      lastBackupTime: lastBackupTime ?? this.lastBackupTime,
    );
  }
}
