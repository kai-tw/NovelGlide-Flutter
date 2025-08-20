import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/backup_target_type.dart';
import '../../../../domain/entities/backup_task_type.dart';
import '../states/backup_service_process_item_state.dart';

abstract class BackupServiceProcessItemCubit
    extends Cubit<BackupServiceProcessItemState> {
  BackupServiceProcessItemCubit({this.googleDriveFileId})
      : super(const BackupServiceProcessItemState());

  final String? googleDriveFileId;
  abstract final BackupTargetType targetType;

  /// Start the process.
  void startUp({
    required BackupTaskType taskType,
    required BackupTargetType targetType,
  }) {
    // Do we need to work?
    if (targetType != BackupTargetType.all && targetType != this.targetType) {
      return;
    }

    switch (taskType) {
      case BackupTaskType.create:
        createBackup();
        break;

      case BackupTaskType.restore:
        restoreBackup();
        break;

      case BackupTaskType.delete:
        deleteBackup();
        break;
    }
  }

  /// Create a backup.
  Future<void> createBackup();

  /// Restore from a backup.
  Future<void> restoreBackup();

  /// Delete a backup.
  Future<void> deleteBackup();
}
