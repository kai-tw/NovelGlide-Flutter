part of '../backup_manager_google_drive.dart';

class _ProcessDialogState extends Equatable {
  final _ProcessStep step;
  final double? progress;

  const _ProcessDialogState({
    this.step = _ProcessStep.archive,
    this.progress,
  });

  @override
  List<Object?> get props => [step, progress];
}

enum _ProcessStep { archive, upload, done }
