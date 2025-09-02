import 'package:equatable/equatable.dart';

import 'downloader_task_state.dart';

class DownloaderTask extends Equatable {
  const DownloaderTask({
    required this.stateCode,
    required this.uri,
    required this.savePath,
    required this.onDownloadStream,
    required this.isManaged,
  });

  final DownloaderTaskState stateCode;
  final Uri uri;
  final String savePath;
  final Stream<double> onDownloadStream;
  // Is this task managed by app.
  final bool isManaged;

  @override
  List<Object?> get props => <Object?>[
        stateCode,
        uri,
        savePath,
        onDownloadStream,
        isManaged,
      ];

  DownloaderTask copyWith({
    DownloaderTaskState? stateCode,
    Uri? uri,
    String? savePath,
    Stream<double>? onDownloadStream,
    bool? isManaged,
  }) {
    return DownloaderTask(
      stateCode: stateCode ?? this.stateCode,
      uri: uri ?? this.uri,
      savePath: savePath ?? this.savePath,
      onDownloadStream: onDownloadStream ?? this.onDownloadStream,
      isManaged: isManaged ?? this.isManaged,
    );
  }
}
