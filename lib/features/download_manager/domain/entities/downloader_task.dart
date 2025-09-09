import 'package:equatable/equatable.dart';

import 'downloader_task_state.dart';

class DownloaderTask extends Equatable {
  const DownloaderTask({
    required this.stateCode,
    required this.name,
    required this.uri,
    required this.savePath,
    required this.onDownloadStream,
    required this.startTime,
  });

  final DownloaderTaskState stateCode;
  final String name;
  final Uri uri;
  final String savePath;
  final Stream<double> onDownloadStream;
  final DateTime startTime;

  @override
  List<Object?> get props => <Object?>[
        stateCode,
        name,
        uri,
        savePath,
        onDownloadStream,
        startTime,
      ];

  DownloaderTask copyWith({
    DownloaderTaskState? stateCode,
    String? name,
    Uri? uri,
    String? savePath,
    Stream<double>? onDownloadStream,
    DateTime? startTime,
  }) {
    return DownloaderTask(
      stateCode: stateCode ?? this.stateCode,
      name: name ?? this.name,
      uri: uri ?? this.uri,
      savePath: savePath ?? this.savePath,
      onDownloadStream: onDownloadStream ?? this.onDownloadStream,
      startTime: startTime ?? this.startTime,
    );
  }
}
