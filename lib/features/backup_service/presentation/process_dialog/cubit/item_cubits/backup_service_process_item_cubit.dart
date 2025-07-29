part of '../../../../backup_service.dart';

abstract class BackupServiceProcessItemCubit
    extends Cubit<BackupServiceProcessItemState> {
  BackupServiceProcessItemCubit({this.googleDriveFileId})
      : super(const BackupServiceProcessItemState());

  final String? googleDriveFileId;
  abstract final BackupTargetType _targetType;

  /// Start the process.
  void startUp({
    required BackupTaskType taskType,
    required BackupTargetType targetType,
  }) {
    // Do we need to work?
    if (targetType != BackupTargetType.all && targetType != _targetType) {
      return;
    }

    switch (taskType) {
      case BackupTaskType.create:
        _create();
        break;

      case BackupTaskType.restore:
        _restore();
        break;

      case BackupTaskType.delete:
        _delete();
        break;
    }
  }

  /// Create a backup.
  Future<void> _create();

  /// Restore from a backup.
  Future<void> _restore();

  /// Delete a backup.
  Future<void> _delete();
}
