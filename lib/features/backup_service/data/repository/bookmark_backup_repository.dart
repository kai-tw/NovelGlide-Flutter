part of '../../backup_service.dart';

class BookmarkBackupRepository extends BackupRepository {
  BookmarkBackupRepository();

  @override
  Future<String> get fileName => BookmarkService.repository.jsonFileName;

  Future<bool> isBackupExists() async =>
      GoogleApiInterfaces.drive.fileExists(await fileName);

  Future<bool> uploadToGoogleDrive({void Function(int, int)? onUpload}) async {
    try {
      await GoogleApiInterfaces.drive.uploadFile(
        (await BookmarkService.repository.jsonFile).file,
        onUpload: onUpload,
      );
    } catch (e) {
      LogSystem.error(
        'Failed to upload bookmark backup to Google Drive.',
        error: e,
      );
      return false;
    }

    return isBackupExists();
  }

  Future<File?> downloadFromGoogleDrive({
    void Function(int, int)? onDownload,
  }) async {
    if ((await googleDriveFileId) == null) {
      LogSystem.error('Google Drive file id of the bookmark backup is null.');
      return null;
    }

    final File jsonFile = File(join(tempDirectory!.path, await fileName));

    try {
      await GoogleApiInterfaces.drive.downloadFile(
        (await googleDriveFileId)!,
        jsonFile,
        onDownload: onDownload,
      );
    } catch (e) {
      LogSystem.error(
        'Download bookmark backup from Google Drive failed.',
        error: e,
      );
      return null;
    }

    return jsonFile;
  }

  Future<bool> deleteFromGoogleDrive() async {
    if ((await googleDriveFileId) == null) {
      LogSystem.error('Google Drive file id of the bookmark backup is null.');
      return false;
    }

    try {
      await GoogleApiInterfaces.drive.deleteFile((await googleDriveFileId)!);
    } catch (e) {
      LogSystem.error(
        'Delete bookmark backup from Google Drive failed.',
        error: e,
      );
      return false;
    }

    return !(await isBackupExists());
  }

  Future<void> importData(File file) async {
    // Clear the current data.
    await BookmarkService.repository.reset();

    // Import the data.
    final JsonFileMetaModel jsonFile = FileSystemService.json.getJsonFile(file);
    final Map<String, dynamic> jsonData = jsonFile.data;

    // Parse the data.
    final Set<BookmarkData> dataSet = <BookmarkData>{};
    for (String key in jsonData.keys) {
      dataSet.add(BookmarkData.fromJson(jsonData[key]!));
    }

    // Update the data to the repository.
    await BookmarkService.repository.updateData(dataSet);
  }
}
