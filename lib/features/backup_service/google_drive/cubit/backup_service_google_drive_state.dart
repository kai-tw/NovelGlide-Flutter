part of 'backup_service_google_drive_cubit.dart';

class BackupServiceGoogleDriveState extends Equatable {
  const BackupServiceGoogleDriveState({
    this.code = LoadingStateCode.initial,
    this.libraryId,
    this.collectionId,
    this.bookmarkId,
    this.lastBackupTime,
  });

  final LoadingStateCode code;
  final String? libraryId;
  final String? collectionId;
  final String? bookmarkId;
  final DateTime? lastBackupTime;

  @override
  List<Object?> get props => <Object?>[
        code,
        libraryId,
        collectionId,
        bookmarkId,
        lastBackupTime,
      ];

  /// Creates a copy of the current state with optional new values.
  BackupServiceGoogleDriveState copyWith({
    LoadingStateCode? code,
    String? libraryId,
    String? collectionId,
    String? bookmarkId,
    DateTime? lastBackupTime,
  }) {
    return BackupServiceGoogleDriveState(
      code: code ?? this.code,
      libraryId: libraryId ?? this.libraryId,
      collectionId: collectionId ?? this.collectionId,
      bookmarkId: bookmarkId ?? this.bookmarkId,
      lastBackupTime: lastBackupTime ?? this.lastBackupTime,
    );
  }
}
