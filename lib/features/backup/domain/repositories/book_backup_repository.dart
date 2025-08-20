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
    void Function(double progress)? onUpload,
  );

  Future<String?> downloadFromCloud(
    String tempDirectoryPath,
    void Function(double progress)? onDownload,
  );

  Future<bool> deleteFromCloud();
}
