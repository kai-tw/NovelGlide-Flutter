part of '../../backup_service.dart';

class BookBackupRepository extends BackupRepository {
  BookBackupRepository();

  @override
  Future<String> get fileName async => 'Library.zip';

  /// Archive library to a zip file.
  Future<File> archive({
    void Function(double)? onZipping,
  }) async {
    // Get the library directory
    final Directory libraryFolder =
        await FileSystemService.document.libraryDirectory;

    // Create the zip file
    final File zipFile = File(join(tempDirectory!.path, await fileName));

    // Start archiving books
    await ZipFile.createFromDirectory(
      sourceDir: libraryFolder,
      zipFile: zipFile,
      onZipping: (String fileName, bool isDirectory, double progress) {
        // Call callback for sending the progress.
        onZipping?.call(progress);

        // Only include epub files.
        // TODO(kai): Replace with BookService.repository.isFileValid(fileName)?
        return !isDirectory && extension(fileName) == '.epub'
            ? ZipFileOperation.includeItem
            : ZipFileOperation.skipItem;
      },
    );

    return zipFile;
  }

  /// Extract the backup file to library.
  Future<void> extract({
    required File zipFile,
    void Function(double)? onExtracting,
  }) async {
    // Extract files to temporary directory.
    await ZipFile.extractToDirectory(
      zipFile: zipFile,
      destinationDir: tempDirectory!,
      onExtracting: (ZipEntry entry, double progress) {
        // Only extract epub files.
        onExtracting?.call(progress);

        // Determine if the file should be extracted or not.
        return !entry.isDirectory && extension(entry.name) == '.epub'
            ? ZipFileOperation.includeItem
            : ZipFileOperation.skipItem;
      },
    );

    // Get all paths of every book.
    final Set<String> bookFileSet = tempDirectory!
        .listSync()
        .whereType<File>()
        .where((File file) => BookService.repository.isFileValid(file))
        .map((File file) => file.path)
        .toSet();

    // Delete all books in the library
    await BookService.repository.deleteAllBooks();

    // Perform add book procedures
    await BookService.repository.addBooks(bookFileSet);
  }

  Future<bool> isBackupExists() async =>
      GoogleApiInterfaces.drive.fileExists(await fileName);

  /// Upload zip to google drive.
  /// Return true if it's successful.
  Future<bool> uploadToGoogleDrive({
    required File zipFile,
    void Function(int, int)? onUpload,
  }) async {
    try {
      await GoogleApiInterfaces.drive.uploadFile(zipFile, onUpload: onUpload);
    } catch (e) {
      // An error occurred.
      LogSystem.error('Upload library zip to Google Drive failed', error: e);
      return false;
    }

    return isBackupExists();
  }

  /// Download the zip from google drive.
  /// Return the saved file if it's successful
  Future<File?> downloadFromGoogleDrive({
    void Function(int, int)? onDownload,
  }) async {
    if (await googleDriveFileId == null) {
      LogSystem.error('Download library backup failed.'
          'Google Drive file id is null');
      return null;
    }

    // Create an empty file to store the downloaded zip file.
    final File zipFile = File(join(tempDirectory!.path, await fileName));
    zipFile.createSync();

    try {
      final String? fileId = await googleDriveFileId;
      await GoogleApiInterfaces.drive
          .downloadFile(fileId!, zipFile, onDownload: onDownload);
    } catch (e) {
      // An error occurred.
      LogSystem.error('Google Drive download file failed', error: e);
      return null;
    }

    return zipFile;
  }

  /// Delete the backup file from Google Drive
  /// Return true if it's successful
  Future<bool> deleteFromGoogleDrive() async {
    if (await googleDriveFileId == null) {
      LogSystem.error('Delete library backup failed.'
          'Google Drive file id is null.');
      return false;
    }

    // Delete the file from Google Drive.
    final String? fileId = await googleDriveFileId;
    await GoogleApiInterfaces.drive.deleteFile(fileId!);

    // Success if it doesn't exist.
    return !(await isBackupExists());
  }
}
