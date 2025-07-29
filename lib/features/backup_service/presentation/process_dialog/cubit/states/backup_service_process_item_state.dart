part of '../../../../backup_service.dart';

class BackupServiceProcessItemState extends Equatable {
  const BackupServiceProcessItemState({
    this.step = BackupProgressStepCode.disabled,
    this.progress = 0,
  });

  final BackupProgressStepCode step;
  final double progress;

  bool get isRunning =>
      step != BackupProgressStepCode.disabled &&
      step != BackupProgressStepCode.done &&
      step != BackupProgressStepCode.error;

  @override
  List<Object?> get props => <Object?>[step, progress];
}
