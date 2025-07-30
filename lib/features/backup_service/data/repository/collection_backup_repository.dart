part of '../../backup_service.dart';

class CollectionBackupRepository extends BackupRepository {
  @override
  Future<String> get fileName => CollectionService.repository.jsonFileName;

  Future<bool> uploadToGoogleDrive({void Function(int, int)? onUpload}) async {
    try {
      await GoogleApiInterfaces.drive.uploadFile(
        (await CollectionService.repository.jsonFile).file,
        onUpload: onUpload,
      );
    } catch (e) {
      LogService.error(
        'Failed to upload collection json file to Google Drive',
        error: e,
      );
      return false;
    }

    return await GoogleApiInterfaces.drive.fileExists(await fileName);
  }

  Future<File?> downloadFromGoogleDrive({
    void Function(int, int)? onDownload,
  }) async {
    if ((await googleDriveFileId) == null) {
      LogService.error(
          'Google Drive file id of the collection backup is null.');
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
      LogService.error(
        'Download bookmark backup from Google Drive failed.',
        error: e,
      );
      return null;
    }

    return jsonFile;
  }

  Future<bool> deleteFromGoogleDrive() async {
    if ((await googleDriveFileId) == null) {
      LogService.error(
          'Google Drive file id of the collection backup is null.');
      return false;
    }

    try {
      await GoogleApiInterfaces.drive.deleteFile((await googleDriveFileId)!);
    } catch (e) {
      LogService.error(
        'Failed to delete collection backup from Google Drive.',
        error: e,
      );
      return false;
    }

    return !(await GoogleApiInterfaces.drive.fileExists(await fileName));
  }

  Future<void> importData(File file) async {
    // Clear the current data.
    await CollectionService.repository.reset();

    // Import the data.
    final JsonFileMetaModel jsonFile = FileSystemService.json.getJsonFile(file);
    final Map<String, dynamic> jsonData = jsonFile.data;

    // Parse the data.
    final Set<CollectionData> dataSet = <CollectionData>{};
    for (String key in jsonData.keys) {
      dataSet.add(CollectionData.fromJson(jsonData[key]!));
    }

    // Update the data to the repository.
    await CollectionService.repository.updateData(dataSet);
  }
}
