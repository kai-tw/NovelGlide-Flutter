part of 'process_cubit.dart';

class BackupManagerProcessAllDialogState extends Equatable {
  final bool isLibraryRunning;
  final bool isCollectionRunning;
  final bool isBookmarkRunning;
  final BackupManagerProcessStepCode libraryStep;
  final BackupManagerProcessStepCode collectionStep;
  final BackupManagerProcessStepCode bookmarkStep;
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

  const BackupManagerProcessAllDialogState({
    this.isLibraryRunning = false,
    this.isCollectionRunning = false,
    this.isBookmarkRunning = false,
    this.libraryStep = BackupManagerProcessStepCode.idle,
    this.collectionStep = BackupManagerProcessStepCode.idle,
    this.bookmarkStep = BackupManagerProcessStepCode.idle,
    this.libraryProgress = 0,
    this.collectionProgress = 0,
    this.bookmarkProgress = 0,
  });

  BackupManagerProcessAllDialogState copyWith({
    bool? isLibraryRunning,
    bool? isCollectionRunning,
    bool? isBookmarkRunning,
    BackupManagerProcessStepCode? libraryStep,
    BackupManagerProcessStepCode? collectionStep,
    BackupManagerProcessStepCode? bookmarkStep,
    double? libraryProgress,
    double? collectionProgress,
    double? bookmarkProgress,
  }) {
    return BackupManagerProcessAllDialogState(
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
