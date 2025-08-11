part of 'backup_service_google_drive_cubit.dart';

class BackupServiceGoogleDriveState extends Equatable {
  const BackupServiceGoogleDriveState({
    this.code = LoadingStateCode.initial,
    this.isBookBackupExists = false,
    this.isBookmarkBackupExists = false,
    this.isCollectionBackupExists = false,
    this.lastBackupTime,
  });

  final LoadingStateCode code;
  final bool isBookBackupExists;
  final bool isBookmarkBackupExists;
  final bool isCollectionBackupExists;
  final DateTime? lastBackupTime;

  @override
  List<Object?> get props => <Object?>[
        code,
        isBookBackupExists,
        isBookmarkBackupExists,
        isCollectionBackupExists,
        lastBackupTime,
      ];

  /// Creates a copy of the current state with optional new values.
  BackupServiceGoogleDriveState copyWith({
    LoadingStateCode? code,
    bool? isBookBackupExists,
    bool? isBookmarkBackupExists,
    bool? isCollectionBackupExists,
    DateTime? lastBackupTime,
  }) {
    return BackupServiceGoogleDriveState(
      code: code ?? this.code,
      isBookBackupExists: isBookBackupExists ?? this.isBookBackupExists,
      isBookmarkBackupExists:
          isBookmarkBackupExists ?? this.isBookmarkBackupExists,
      isCollectionBackupExists:
          isCollectionBackupExists ?? this.isCollectionBackupExists,
      lastBackupTime: lastBackupTime ?? this.lastBackupTime,
    );
  }
}
