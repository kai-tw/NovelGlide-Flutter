abstract class CollectionBackupRepository {
  Future<String> get fileName;

  Future<bool> isBackupExists();

  Future<bool> uploadToCloud(void Function(int uploaded, int total)? onUpload);

  Future<String?> downloadFromCloud(
    String tempDirectoryPath,
    void Function(int downloaded, int total)? onDownload,
  );

  Future<bool> deleteFromCloud();
}
