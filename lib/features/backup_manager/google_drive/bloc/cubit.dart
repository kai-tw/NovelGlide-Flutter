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
    emit(const _State(code: LoadingStateCode.loading));
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool(_drivePrefKey) ?? false;
    final isReady = await _isApiReady(isEnabled);

    if (isReady) {
      final fileNameList = [
        BackupUtils.libraryArchiveName,
        CollectionRepository.jsonFileName,
        BookmarkRepository.jsonFileName,
      ];
      final fileIdList = await Future.wait<String?>(
        fileNameList.map((fileName) => _driveApi.getFileId(fileName)),
      );
      final timeList = (await Future.wait<drive.File>(
        fileIdList.whereType<String>().map((fileId) =>
            _driveApi.getMetadataById(fileId, field: 'modifiedTime')),
      ))
          .map((e) => e.modifiedTime)
          .whereType<DateTime>()
          .toList();
      final lastBackupTime = timeList.isNotEmpty
          ? timeList.reduce((a, b) => a.isAfter(b) ? a : b)
          : null;

      if (!isClosed) {
        emit(_State(
          code: LoadingStateCode.loaded,
          libraryId: fileIdList[0],
          collectionId: fileIdList[1],
          bookmarkId: fileIdList[2],
          lastBackupTime: lastBackupTime,
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
    return false;
  }

  /// Deletes the existing backup from Google Drive.
  Future<bool> deleteAll() async {
    return false;
  }

  /// Restores a backup from Google Drive.
  Future<bool> restoreAll() async {
    return false;
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
