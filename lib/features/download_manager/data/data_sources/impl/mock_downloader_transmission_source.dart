import '../downloader_transmission_source.dart';

class MockDownloaderTransmissionSource implements DownloaderTransmissionSource {
  final Set<String> _runningSet = <String>{};

  @override
  Future<void> downloadFile(
    String identifier,
    Uri uri,
    String savePath,
    void Function(double progress) onDownload,
  ) async {
    if (!_runningSet.contains(identifier)) {
      _runningSet.add(identifier);
      for (int i = 0; i < 101; i += 10) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        onDownload(i / 100);

        if (!_runningSet.contains(identifier)) {
          break;
        }
      }
    }
  }

  @override
  Future<void> cancelDownload(String identifier) async {
    _runningSet.remove(identifier);
  }
}
