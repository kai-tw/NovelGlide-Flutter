abstract class BookBackupRepository {
  Future<String> get archiveName;

  Future<DateTime?> get lastBackupTime;

  Future<String> archive(
    String tempDirectoryPath,
    void Function(double progress)? onZipping,
  );

  Future<void> extract(
    String zipFilePath,
    String tempDirectoryPath,
    void Function(double progress)? onExtracting,
  );

  Future<bool> isBackupExists();

  Future<bool> uploadToCloud(
    String zipFilePath,
    void Function(int uploaded, int total)? onUpload,
  );

  Future<String?> downloadFromCloud(
    String tempDirectoryPath,
    void Function(int downloaded, int total)? onDownload,
  );

  Future<bool> deleteFromCloud();
}
