import 'package:dio/dio.dart';

import '../downloader_transmission_source.dart';

class DownloaderTransmissionDioSource implements DownloaderTransmissionSource {
  final Dio _dio = Dio();
  final Map<String, CancelToken> _tokenMap = <String, CancelToken>{};

  @override
  Future<void> downloadFile(
    String identifier,
    Uri uri,
    String savePath,
    void Function(double progress) onDownload,
  ) async {
    _tokenMap[identifier] = CancelToken();

    await _dio.downloadUri(
      uri,
      savePath,
      cancelToken: _tokenMap[identifier],
      onReceiveProgress: (int received, int total) {
        if (total != -1) {
          onDownload((received / total).clamp(0, 1));
        }
      },
    );

    if (_tokenMap.containsKey(identifier)) {
      _tokenMap.remove(identifier);
    }
  }

  @override
  Future<void> cancelDownload(String identifier) async {
    if (_tokenMap.containsKey(identifier)) {
      _tokenMap[identifier]?.cancel();
      _tokenMap.remove(identifier);
    }
  }
}
