part of 'backup_manager_google_drive_cubit.dart';

class BackupManagerGoogleDriveState extends Equatable {
  final LoadingStateCode code;
  final String? libraryId;
  final String? collectionId;
  final String? bookmarkId;
  final DateTime? lastBackupTime;

  const BackupManagerGoogleDriveState({
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
  BackupManagerGoogleDriveState copyWith({
    LoadingStateCode? code,
    String? libraryId,
    String? collectionId,
    String? bookmarkId,
    DateTime? lastBackupTime,
  }) {
    return BackupManagerGoogleDriveState(
      code: code ?? this.code,
      libraryId: libraryId ?? this.libraryId,
      collectionId: collectionId ?? this.collectionId,
      bookmarkId: bookmarkId ?? this.bookmarkId,
      lastBackupTime: lastBackupTime ?? this.lastBackupTime,
    );
  }
}
