import 'dart:async';
import 'dart:io';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:path/path.dart';

import '../exceptions.dart';
import '../utils/int_utils.dart';
import 'mime_resolver.dart';

/// Google Drive API.
class GoogleDriveService {
  GoogleDriveService._();

  static final List<String> _scopes = <String>[
    drive.DriveApi.driveAppdataScope,
    drive.DriveApi.driveFileScope,
  ];

  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: _scopes);
  static drive.DriveApi? _driveApi;
  static const String appDataFolder = 'appDataFolder';

  /// Signs in the user and initializes the Drive API client.
  static Future<void> signIn() async {
    if (_googleSignIn.currentUser == null &&
        await _googleSignIn.signInSilently() == null &&
        await _googleSignIn.signIn() == null) {
      throw PlatformException(code: GoogleSignIn.kSignInFailedError);
    }

    if (!await _googleSignIn.requestScopes(_scopes)) {
      throw PlatformException(code: ExceptionCode.googleDrivePermissionDenied);
    }

    final AuthClient? httpClient = await _googleSignIn.authenticatedClient();

    if (httpClient == null) {
      throw PlatformException(code: GoogleSignIn.kSignInFailedError);
    } else {
      _driveApi = drive.DriveApi(httpClient);
    }
  }

  /// Signs out the user and clears the Drive API client.
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    _driveApi = null;
  }

  /// Checks if the user is signed in and the Drive API client is initialized.
  static Future<bool> isSignedIn() async =>
      await _googleSignIn.isSignedIn() && _driveApi != null;

  static drive.FilesResource get files => _driveApi!.files;

  /// Checks if the file exists in Google Drive.
  static Future<bool> fileExists(
    String fileName, {
    String spaces = appDataFolder,
  }) async {
    return await getFileId(fileName, spaces: spaces) != null;
  }

  /// Retrieves the file ID for a given file name in the app data folder.
  static Future<String?> getFileId(
    String fileName, {
    String spaces = appDataFolder,
  }) async {
    final drive.FileList fileList = await files.list(
      spaces: spaces,
      q: "name = '$fileName'",
      pageSize: 1,
    );
    return fileList.files?.isNotEmpty ?? false
        ? fileList.files?.first.id
        : null;
  }

  /// Retrieves metadata for a file by its ID.
  static Future<drive.File> getMetadataById(String fileId,
      {String? field}) async {
    return await files.get(fileId, $fields: field) as drive.File;
  }

  /// Copies a file to specified parent folders.
  static Future<void> copyFile(String fileId, List<String> parents) async {
    final drive.File request = drive.File();
    request.parents = parents;
    await files.copy(request, fileId);
  }

  /// Deletes a file by its ID.
  static Future<void> deleteFile(String fileId) async {
    await files.delete(fileId);
  }

  /// Uploads a file to Google Drive, updating if it already exists.
  static Future<void> uploadFile(String spaces, File file) async {
    final String? fileId = await getFileId(basename(file.path));

    final drive.File driveFile = drive.File();
    driveFile.name = basename(file.path);
    driveFile.mimeType = MimeResolver.lookupAll(file);

    final drive.Media media = drive.Media(file.openRead(), file.lengthSync());

    if (fileId != null) {
      await files.update(driveFile, fileId, uploadMedia: media);
    } else {
      driveFile.parents = <String>[spaces];
      await files.create(driveFile, uploadMedia: media);
    }
  }

  /// Downloads a file from Google Drive and saves it locally.
  static Future<void> downloadFile(
    String fileId,
    File saveFile, {
    void Function(int, int)? onDownload,
  }) async {
    final Completer<void> completer = Completer<void>();
    final List<int> buffer = <int>[];

    final drive.File fileStat = await getMetadataById(fileId, field: 'size');
    final int fileSize = IntUtils.parse(fileStat.size);

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
