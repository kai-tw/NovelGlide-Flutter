abstract class BookmarkBackupRepository {
  Future<String> get fileName;

  Future<DateTime?> get lastBackupTime;

  Future<bool> isBackupExists();

  Future<bool> uploadToCloud(void Function(double progress)? onUpload);

  Future<String?> downloadFromCloud(
    String tempDirectoryPath,
    void Function(double progress)? onDownload,
  );

  Future<bool> deleteFromCloud();
}
