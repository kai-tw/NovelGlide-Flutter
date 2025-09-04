import 'package:equatable/equatable.dart';

import '../../../domain/entities/downloader_task_state.dart';

class DownloadManagerTaskListItemState extends Equatable {
  const DownloadManagerTaskListItemState({
    this.stateCode = DownloaderTaskState.initial,
    this.fileName = '',
    this.progress,
    this.startTime,
  });

  final DownloaderTaskState stateCode;
  final String fileName;
  final double? progress;
  final DateTime? startTime;

  @override
  List<Object?> get props => <Object?>[
        stateCode,
        fileName,
        progress,
        startTime,
      ];

  DownloadManagerTaskListItemState copyWith({
    DownloaderTaskState? stateCode,
    String? fileName,
    double? progress,
    DateTime? startTime,
  }) {
    return DownloadManagerTaskListItemState(
      stateCode: stateCode ?? this.stateCode,
      fileName: fileName ?? this.fileName,
      progress: progress ?? this.progress,
      startTime: startTime ?? this.startTime,
    );
  }
}
