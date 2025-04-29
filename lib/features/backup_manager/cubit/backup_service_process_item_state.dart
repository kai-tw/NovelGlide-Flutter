part of 'backup_service_process_cubit.dart';

class BackupServiceProcessItemState extends Equatable {
  const BackupServiceProcessItemState({
    this.step = BackupServiceProcessStepCode.disabled,
    this.progress = 0,
  });

  final BackupServiceProcessStepCode step;
  final double progress;

  bool get isRunning =>
      step != BackupServiceProcessStepCode.disabled &&
      step != BackupServiceProcessStepCode.done &&
      step != BackupServiceProcessStepCode.error;

  @override
  List<Object?> get props => <Object?>[step, progress];
}
