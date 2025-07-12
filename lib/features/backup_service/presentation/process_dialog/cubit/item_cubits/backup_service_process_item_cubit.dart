part of '../../../../backup_service.dart';

abstract class BackupServiceProcessItemCubit
    extends Cubit<BackupServiceProcessItemState> {
  BackupServiceProcessItemCubit({this.googleDriveFileId})
      : super(const BackupServiceProcessItemState());

  final String? googleDriveFileId;
  abstract final BackupServiceTargetType _targetType;

  /// Start the process.
  void startUp({
    required BackupServiceTaskType taskType,
    required BackupServiceTargetType targetType,
  }) {
    // Do we need to work?
    if (targetType != BackupServiceTargetType.all &&
        targetType != _targetType) {
      return;
    }

    switch (taskType) {
      case BackupServiceTaskType.backup:
        _backup();
        break;

      case BackupServiceTaskType.restore:
        _restore();
        break;

      case BackupServiceTaskType.delete:
        _delete();
        break;
    }
  }

  /// Backup the library.
  Future<void> _backup();

  /// Restore the library.
  Future<void> _restore();

  /// Delete the library.
  Future<void> _delete();
}
