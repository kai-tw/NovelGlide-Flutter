import '../../../../domain/entities/backup_progress_data.dart';
import '../../../../domain/entities/backup_target_type.dart';
import '../../../../domain/use_cases/backup_bookmark_create_use_case.dart';
import '../../../../domain/use_cases/backup_bookmark_delete_use_case.dart';
import '../../../../domain/use_cases/backup_bookmark_restore_use_case.dart';
import '../states/backup_service_process_item_state.dart';
import 'backup_service_process_item_cubit.dart';

class BackupServiceProcessBookmarkCubit extends BackupServiceProcessItemCubit {
  BackupServiceProcessBookmarkCubit(
      this._createUseCase, this._restoreUseCase, this._deleteUseCase);

  /// Use cases
  final BackupBookmarkCreateUseCase _createUseCase;
  final BackupBookmarkRestoreUseCase _restoreUseCase;
  final BackupBookmarkDeleteUseCase _deleteUseCase;

  @override
  final BackupTargetType targetType = BackupTargetType.bookmark;

  /// Backup the bookmark.
  @override
  Future<void> createBackup() async {
    _createUseCase().listen((BackupProgressData data) {
      emit(BackupServiceProcessItemState(
        step: data.step,
        progress: data.progress,
      ));
    });
  }

  /// Restore the bookmark.
  @override
  Future<void> restoreBackup() async {
    _restoreUseCase().listen((BackupProgressData data) {
      emit(BackupServiceProcessItemState(
        step: data.step,
        progress: data.progress,
      ));
    });
  }

  /// Delete the bookmark.
  @override
  Future<void> deleteBackup() async {
    _deleteUseCase().listen((BackupProgressData data) {
      emit(BackupServiceProcessItemState(
        step: data.step,
        progress: data.progress,
      ));
    });
  }
}
