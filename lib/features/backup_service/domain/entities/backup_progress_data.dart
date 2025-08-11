import 'package:equatable/equatable.dart';

import 'backup_progress_step_code.dart';

class BackupProgressData extends Equatable {
  const BackupProgressData({
    this.step = BackupProgressStepCode.disabled,
    this.progress = 0,
  });

  final BackupProgressStepCode step;
  final double progress;

  @override
  List<Object?> get props => <Object?>[step, progress];
}
