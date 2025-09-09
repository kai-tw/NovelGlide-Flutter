import 'package:equatable/equatable.dart';

import '../../../domain/entities/downloader_task_state.dart';

class DownloadManagerTaskListItemState extends Equatable {
  const DownloadManagerTaskListItemState({
    this.stateCode = DownloaderTaskState.initial,
    this.taskName = '',
    this.progress,
    this.startTime,
  });

  final DownloaderTaskState stateCode;
  final String taskName;
  final double? progress;
  final DateTime? startTime;

  @override
  List<Object?> get props => <Object?>[
        stateCode,
        taskName,
        progress,
        startTime,
      ];

  DownloadManagerTaskListItemState copyWith({
    DownloaderTaskState? stateCode,
    String? taskName,
    double? progress,
    DateTime? startTime,
  }) {
    return DownloadManagerTaskListItemState(
      stateCode: stateCode ?? this.stateCode,
      taskName: taskName ?? this.taskName,
      progress: progress ?? this.progress,
      startTime: startTime ?? this.startTime,
    );
  }
}
