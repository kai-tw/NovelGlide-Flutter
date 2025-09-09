import '../../../../domain/entities/backup_progress_data.dart';
import '../../../../domain/entities/backup_target_type.dart';
import '../../../../domain/use_cases/backup_collection_create_use_case.dart';
import '../../../../domain/use_cases/backup_collection_delete_use_case.dart';
import '../../../../domain/use_cases/backup_collection_restore_use_case.dart';
import '../states/backup_service_process_item_state.dart';
import 'backup_service_process_item_cubit.dart';

class BackupServiceProcessCollectionCubit
    extends BackupServiceProcessItemCubit {
  BackupServiceProcessCollectionCubit(
    this._createUseCase,
    this._restoreUseCase,
    this._deleteUseCase,
  );

  /// Use cases
  final BackupCollectionCreateUseCase _createUseCase;
  final BackupCollectionRestoreUseCase _restoreUseCase;
  final BackupCollectionDeleteUseCase _deleteUseCase;

  @override
  final BackupTargetType targetType = BackupTargetType.collection;

  /// Back collections up
  @override
  Future<void> createBackup() async {
    _createUseCase().listen((BackupProgressData data) {
      emit(BackupServiceProcessItemState(
        step: data.step,
        progress: data.progress,
      ));
    });
  }

  /// Restore from the collection backup.
  @override
  Future<void> restoreBackup() async {
    _restoreUseCase().listen((BackupProgressData data) {
      emit(BackupServiceProcessItemState(
        step: data.step,
        progress: data.progress,
      ));
    });
  }

  /// Delete the collection backup.
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
