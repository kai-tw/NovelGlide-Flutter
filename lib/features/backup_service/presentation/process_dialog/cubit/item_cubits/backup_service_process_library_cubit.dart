import '../../../../domain/entities/backup_progress_data.dart';
import '../../../../domain/entities/backup_target_type.dart';
import '../../../../domain/use_cases/backup_book_create_use_case.dart';
import '../../../../domain/use_cases/backup_book_delete_use_case.dart';
import '../../../../domain/use_cases/backup_book_restore_use_case.dart';
import '../states/backup_service_process_item_state.dart';
import 'backup_service_process_item_cubit.dart';

class BackupServiceProcessLibraryCubit extends BackupServiceProcessItemCubit {
  BackupServiceProcessLibraryCubit(
    this._createUseCase,
    this._restoreUseCase,
    this._deleteUseCase,
  );

  /// Use cases
  final BackupBookCreateUseCase _createUseCase;
  final BackupBookRestoreUseCase _restoreUseCase;
  final BackupBookDeleteUseCase _deleteUseCase;

  @override
  final BackupTargetType targetType = BackupTargetType.library;

  /// Backup the library.
  @override
  Future<void> createBackup() async {
    _createUseCase().listen((BackupProgressData data) {
      emit(BackupServiceProcessItemState(
        step: data.step,
        progress: data.progress,
      ));
    });
  }

  /// Restore the library.
  @override
  Future<void> restoreBackup() async {
    _restoreUseCase().listen((BackupProgressData data) {
      emit(BackupServiceProcessItemState(
        step: data.step,
        progress: data.progress,
      ));
    });
  }

  /// Delete the library.
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
