part of 'google_api_interfaces.dart';

/// Google Drive API.
class GoogleDriveInterface {
  GoogleDriveInterface._();

  static const String _appDataFolder = 'appDataFolder';
  static final List<String> _scopes = <String>[
    drive.DriveApi.driveAppdataScope,
    drive.DriveApi.driveFileScope,
  ];

  final GoogleAuthInterface _authService = GoogleApiInterfaces.auth;
  drive.DriveApi? _driveApi;

  /// Checks if the user is signed in and the Drive API client is initialized.
  bool get isSignedIn => _authService.isSignedIn && _driveApi != null;

  drive.FilesResource get files => _driveApi!.files;

  /// Signs in the user and initializes the Drive API client.
  Future<void> signIn() async {
    await _authService.signIn();
    final GoogleAuthClient client = await _authService.getClient(_scopes);
    _driveApi = drive.DriveApi(client);
  }

  /// Signs out the user and clears the Drive API client.
  Future<void> signOut() async {
    await _authService.signOut();
    _driveApi = null;
  }

  /// Checks if the file exists in Google Drive.
  Future<bool> fileExists(
    String fileName, {
    String spaces = _appDataFolder,
  }) async {
    return await getFileId(fileName, spaces: spaces) != null;
  }

  /// Retrieves the file ID for a given file name in the app data folder.
  Future<String?> getFileId(
    String fileName, {
    String spaces = _appDataFolder,
  }) async {
    final drive.FileList fileList = await files.list(
      spaces: spaces,
      q: "name = '$fileName'",
      pageSize: 1,
    );
    return fileList.files?.isNotEmpty ?? false ? fileList.files?.first.id : null;
  }

  /// Retrieves metadata for a file by its ID.
  Future<drive.File> getMetadataById(String fileId, {String? field}) async {
    return await files.get(fileId, $fields: field) as drive.File;
  }

  /// Copies a file to specified parent folders.
  Future<void> copyFile(String fileId, List<String> parents) async {
    final drive.File request = drive.File();
    request.parents = parents;
    await files.copy(request, fileId);
  }

  /// Deletes a file by its ID.
  Future<void> deleteFile(String fileId) async {
    await files.delete(fileId);
  }

  /// Uploads a file to Google Drive, updating if it already exists.
  Future<void> uploadFile(
    File file, {
    String spaces = _appDataFolder,
    void Function(int, int)? onUpload,
  }) async {
    final String? fileId = await getFileId(basename(file.path));

    final drive.File driveFile = drive.File();
    driveFile.name = basename(file.path);
    driveFile.mimeType = MimeResolver.lookupAll(file);

    int byteCount = 0;
    final drive.Media media = drive.Media(
        file.openRead().transform(
              StreamTransformer<List<int>, List<int>>.fromHandlers(
                handleData: (List<int> data, EventSink<List<int>> sink) {
                  byteCount += data.length;
                  onUpload?.call(byteCount, file.lengthSync());
                  sink.add(data);
                },
                handleError: (Object e, StackTrace s, EventSink<List<int>> sink) {
                  LogService.error(
                    'GoogleDriveService.uploadFile: An error occurred',
                    error: e,
                    stackTrace: s,
                  );
                },
                handleDone: (EventSink<List<int>> sink) {
                  sink.close();
                },
              ),
            ),
        file.lengthSync());

    if (fileId != null) {
      await files.update(driveFile, fileId, uploadMedia: media);
    } else {
      driveFile.parents = <String>[spaces];
      await files.create(driveFile, uploadMedia: media);
    }
  }

  /// Downloads a file from Google Drive and saves it locally.
  Future<void> downloadFile(
    String fileId,
    File saveFile, {
    void Function(int, int)? onDownload,
  }) async {
    final Completer<void> completer = Completer<void>();
    final List<int> buffer = <int>[];

    final drive.File fileStat = await getMetadataById(fileId, field: 'size');
    final int fileSize = parseInt(fileStat.size);

    final drive.Media media = await files.get(
      fileId,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;

    media.stream.listen((List<int> data) {
      // A chunk of data has been received.
      // Add it to the buffer and call the onDownload callback.
      buffer.addAll(data);
      onDownload?.call(buffer.length, fileSize);
    }, onDone: () {
      // Download completed. Write the downloaded data to the file.
      saveFile.writeAsBytesSync(buffer);
      buffer.clear();

      // Complete the completer and call the onDone callback.
      completer.complete();
    }, onError: (Object e) {
      // An error occurred.
      // Complete the completer and call the onError callback.
      completer.completeError(e);
    });

    await completer.future;
  }
}
