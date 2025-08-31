abstract class DownloaderTransmissionSource {
  Future<void> downloadFile(
    String identifier,
    Uri uri,
    String savePath,
    void Function(double progress) onDownload,
  );

  Future<void> cancelDownload(String identifier);
}
