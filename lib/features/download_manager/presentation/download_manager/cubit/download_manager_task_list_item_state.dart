import 'package:equatable/equatable.dart';

import '../../../domain/entities/downloader_task_state.dart';

class DownloadManagerTaskListItemState extends Equatable {
  const DownloadManagerTaskListItemState({
    this.stateCode = DownloaderTaskState.initial,
    this.fileName = '',
    this.progress,
  });

  final DownloaderTaskState stateCode;
  final String fileName;
  final double? progress;

  @override
  List<Object?> get props => <Object?>[
        stateCode,
        fileName,
        progress,
      ];

  DownloadManagerTaskListItemState copyWith({
    DownloaderTaskState? stateCode,
    String? fileName,
    double? progress,
  }) {
    return DownloadManagerTaskListItemState(
      stateCode: stateCode ?? this.stateCode,
      fileName: fileName ?? this.fileName,
      progress: progress ?? this.progress,
    );
  }
}
