part of '../backup_manager_google_drive.dart';

class _ProcessCubit extends Cubit<_ProcessState> {
  final _driveApi = GoogleDriveApi.instance;

  _ProcessCubit() : super(const _ProcessState());

  Future<void> backupAll() async {
    Future.wait([
      backupLibrary(),
      backupBookmarks(),
      backupCollections(),
    ]);
  }

  Future<void> backupLibrary() async {
    emit(state.copyWith(
      isLibraryRunning: true,
      libraryStep: _ProcessStep.idle,
    ));

    final tempFolder = RandomUtils.getAvailableTempFolder()
      ..createSync(recursive: true);

    // Zip the library
    final zipFile = await BackupUtils.archiveLibrary(
      tempFolder.path,
      onZipping: (progress) {
        emit(state.copyWith(
          libraryStep: _ProcessStep.zip,
          libraryProgress: progress / 100,
        ));
      },
    );

    // Upload the zip file
    emit(state.copyWith(libraryStep: _ProcessStep.upload));
    await _driveApi.uploadFile('appDataFolder', zipFile);
    tempFolder.deleteSync(recursive: true);

    final result = await _driveApi.fileExists(BackupUtils.libraryArchiveName);
    emit(state.copyWith(
      libraryStep: result ? _ProcessStep.done : _ProcessStep.error,
    ));
  }

  Future<void> backupBookmarks() async {
    // Upload the bookmark file
    emit(state.copyWith(
      isBookmarkRunning: true,
      bookmarkStep: _ProcessStep.upload,
    ));
    final bookmarkFile = BookmarkRepository.jsonFile;
    await _driveApi.uploadFile('appDataFolder', bookmarkFile);

    // Emit the result
    final result = await _driveApi.fileExists(BookmarkRepository.jsonFileName);
    emit(state.copyWith(
      bookmarkStep: result ? _ProcessStep.done : _ProcessStep.error,
    ));
  }

  Future<void> backupCollections() async {
    emit(state.copyWith(
      isCollectionRunning: true,
      collectionStep: _ProcessStep.upload,
    ));
    final collectionFile = CollectionRepository.jsonFile;
    await _driveApi.uploadFile('appDataFolder', collectionFile);

    final result =
        await _driveApi.fileExists(CollectionRepository.jsonFileName);
    emit(state.copyWith(
      collectionStep: result ? _ProcessStep.done : _ProcessStep.error,
    ));
  }

  Future<void> deleteAll({
    required String libraryId,
    required String collectionId,
    required String bookmarkId,
  }) async {
    await Future.wait([
      deleteLibrary(libraryId),
      deleteCollections(collectionId),
      deleteBookmarks(bookmarkId),
    ]);
  }

  Future<void> deleteLibrary(String fileId) async {
    emit(state.copyWith(
      isLibraryRunning: true,
      libraryStep: _ProcessStep.delete,
    ));
    await _driveApi.deleteFile(fileId);
    final result =
        !(await _driveApi.fileExists(BackupUtils.libraryArchiveName));
    emit(state.copyWith(
      libraryStep: result ? _ProcessStep.done : _ProcessStep.error,
    ));
  }

  Future<void> deleteBookmarks(String fileId) async {
    emit(state.copyWith(
      isBookmarkRunning: true,
      bookmarkStep: _ProcessStep.delete,
    ));
    await _driveApi.deleteFile(fileId);
    final result =
        !(await _driveApi.fileExists(BookmarkRepository.jsonFileName));
    emit(state.copyWith(
      bookmarkStep: result ? _ProcessStep.done : _ProcessStep.error,
    ));
  }

  Future<void> deleteCollections(String fileId) async {
    emit(state.copyWith(
      isCollectionRunning: true,
      collectionStep: _ProcessStep.delete,
    ));
    await _driveApi.deleteFile(fileId);
    final result =
        !(await _driveApi.fileExists(CollectionRepository.jsonFileName));
    emit(state.copyWith(
      collectionStep: result ? _ProcessStep.done : _ProcessStep.error,
    ));
  }

  Future<void> restoreAll({
    required String libraryId,
    required String collectionId,
    required String bookmarkId,
  }) async {
    await Future.wait([
      restoreLibrary(libraryId),
      restoreCollections(collectionId),
      restoreBookmarks(bookmarkId),
    ]);
  }

  Future<void> restoreLibrary(String fileId) async {
    emit(state.copyWith(
      isLibraryRunning: true,
      libraryStep: _ProcessStep.idle,
    ));
    final tempFolder = RandomUtils.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);

    final zipFile = File(
      join(
        tempFolder.path,
        BackupUtils.libraryArchiveName,
      ),
    )..createSync();

    // Download the zip file
    await _driveApi.downloadFile(
      fileId,
      zipFile,
      onDownload: (downloaded, total) {
        emit(state.copyWith(
          libraryStep: _ProcessStep.download,
          libraryProgress: (downloaded / total).clamp(0, 1),
        ));
      },
    );

    // Extract the zip file
    emit(state.copyWith(libraryStep: _ProcessStep.unzip));
    await BackupUtils.restoreBackup(
      tempFolder,
      zipFile,
      onExtracting: (progress) {
        emit(state.copyWith(
          libraryStep: _ProcessStep.unzip,
          libraryProgress: progress / 100,
        ));
      },
    );

    tempFolder.deleteSync(recursive: true);
    emit(state.copyWith(libraryStep: _ProcessStep.done));
  }

  Future<void> restoreBookmarks(String fileId) async {
    emit(state.copyWith(
      isBookmarkRunning: true,
      bookmarkStep: _ProcessStep.download,
    ));
    await _driveApi.downloadFile(fileId, BookmarkRepository.jsonFile);
    emit(state.copyWith(bookmarkStep: _ProcessStep.done));
  }

  Future<void> restoreCollections(String fileId) async {
    emit(state.copyWith(
      isCollectionRunning: true,
      collectionStep: _ProcessStep.download,
    ));
    await _driveApi.downloadFile(fileId, CollectionRepository.jsonFile);
    emit(state.copyWith(collectionStep: _ProcessStep.done));
  }
}

class _ProcessState extends Equatable {
  final bool isLibraryRunning;
  final bool isCollectionRunning;
  final bool isBookmarkRunning;
  final _ProcessStep libraryStep;
  final _ProcessStep collectionStep;
  final _ProcessStep bookmarkStep;
  final double libraryProgress;
  final double collectionProgress;
  final double bookmarkProgress;

  @override
  List<Object?> get props => [
        isLibraryRunning,
        isCollectionRunning,
        isBookmarkRunning,
        libraryStep,
        collectionStep,
        bookmarkStep,
        libraryProgress,
        collectionProgress,
        bookmarkProgress,
      ];

  const _ProcessState({
    this.isLibraryRunning = false,
    this.isCollectionRunning = false,
    this.isBookmarkRunning = false,
    this.libraryStep = _ProcessStep.idle,
    this.collectionStep = _ProcessStep.idle,
    this.bookmarkStep = _ProcessStep.idle,
    this.libraryProgress = 0,
    this.collectionProgress = 0,
    this.bookmarkProgress = 0,
  });

  _ProcessState copyWith({
    bool? isLibraryRunning,
    bool? isCollectionRunning,
    bool? isBookmarkRunning,
    _ProcessStep? libraryStep,
    _ProcessStep? collectionStep,
    _ProcessStep? bookmarkStep,
    double? libraryProgress,
    double? collectionProgress,
    double? bookmarkProgress,
  }) {
    return _ProcessState(
      isLibraryRunning: isLibraryRunning ?? this.isLibraryRunning,
      isCollectionRunning: isCollectionRunning ?? this.isCollectionRunning,
      isBookmarkRunning: isBookmarkRunning ?? this.isBookmarkRunning,
      libraryStep: libraryStep ?? this.libraryStep,
      collectionStep: collectionStep ?? this.collectionStep,
      bookmarkStep: bookmarkStep ?? this.bookmarkStep,
      libraryProgress: libraryProgress ?? this.libraryProgress,
      collectionProgress: collectionProgress ?? this.collectionProgress,
      bookmarkProgress: bookmarkProgress ?? this.bookmarkProgress,
    );
  }
}

enum _ProcessStep { idle, zip, upload, unzip, download, delete, done, error }
