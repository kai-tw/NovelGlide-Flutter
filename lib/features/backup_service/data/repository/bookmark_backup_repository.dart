part of '../../backup_service.dart';

class BookmarkBackupRepository {
  BookmarkBackupRepository();

  Future<bool> uploadToGoogleDrive({
    void Function(int, int)? onUpload,
  }) async {
    try {
      await GoogleApiInterfaces.drive.uploadFile(
        (await BookmarkService.repository.jsonFile).file,
        onUpload: onUpload,
      );
    } catch (e) {
      LogService.error('Failed to upload bookmark backup to Google Drive.',
          error: e);
      return false;
    }

    return await GoogleApiInterfaces.drive
        .fileExists(await BookmarkService.repository.jsonFileName);
  }
}
