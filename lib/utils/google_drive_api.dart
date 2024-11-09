import 'dart:async';
import 'dart:io';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

import '../exceptions/exception_template.dart';
import 'int_utils.dart';
import 'mime_resolver.dart';

/// A singleton class to interact with Google Drive API.
class GoogleDriveApi {
  static GoogleDriveApi get instance => _instance;
  static final GoogleDriveApi _instance = GoogleDriveApi._internal();
  static final List<String> _scopes = [
    drive.DriveApi.driveAppdataScope,
    drive.DriveApi.driveFileScope,
  ];

  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: _scopes);
  drive.DriveApi? _driveApi;

  /// Factory constructor to return the singleton instance.
  factory GoogleDriveApi() => _instance;

  /// Internal constructor for singleton pattern.
  GoogleDriveApi._internal();

  /// Signs in the user and initializes the Drive API client.
  Future<void> signIn() async {
    if (await _googleSignIn.signInSilently() == null &&
        await _googleSignIn.signIn() == null) {
      throw GoogleDriveSignInException();
    }

    if (!await _googleSignIn.requestScopes(_scopes)) {
      throw GoogleDrivePermissionDeniedException();
    }

    final AuthClient? httpClient = await _googleSignIn.authenticatedClient();

    if (httpClient == null) {
      throw GoogleDriveSignInException();
    } else {
      _driveApi = drive.DriveApi(httpClient);
    }
  }

  /// Signs out the user and clears the Drive API client.
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _driveApi = null;
  }

  /// Checks if the user is signed in and the Drive API client is initialized.
  Future<bool> isSignedIn() async =>
      await _googleSignIn.isSignedIn() && _driveApi != null;

  /// Lists files in Google Drive with optional query parameters.
  Future<drive.FileList> list({
    String? corpora,
    String? driveId,
    bool? includeItemsFromAllDrives,
    String? includeLabels,
    String? includePermissionsForView,
    bool? includeTeamDriveItems,
    String? orderBy,
    int? pageSize,
    String? pageToken,
    String? q,
    String? spaces,
    bool? supportsAllDrives,
    bool? supportsTeamDrives,
    String? teamDriveId,
    String? $fields,
  }) async {
    return await _driveApi!.files.list(
      corpora: corpora,
      driveId: driveId,
      includeItemsFromAllDrives: includeItemsFromAllDrives,
      includeLabels: includeLabels,
      includePermissionsForView: includePermissionsForView,
      includeTeamDriveItems: includeTeamDriveItems,
      orderBy: orderBy,
      pageSize: pageSize,
      pageToken: pageToken,
      q: q,
      spaces: spaces,
      supportsAllDrives: supportsAllDrives,
      supportsTeamDrives: supportsTeamDrives,
      teamDriveId: teamDriveId,
      $fields: $fields,
    );
  }

  /// Checks if the file exists in Google Drive.
  Future<bool> fileExists(
    String fileName, {
    String spaces = 'appDataFolder',
  }) async {
    return await getFileId(fileName, spaces: spaces) != null;
  }

  /// Retrieves the file ID for a given file name in the app data folder.
  Future<String?> getFileId(
    String fileName, {
    String spaces = 'appDataFolder',
  }) async {
    final drive.FileList fileList = await _driveApi!.files.list(
      spaces: spaces,
      q: "name = '$fileName'",
      pageSize: 1,
    );
    return fileList.files?.isNotEmpty ?? false
        ? fileList.files?.first.id
        : null;
  }

  /// Retrieves metadata for a file by its ID.
  Future<drive.File> getMetadataById(String fileId, {String? field}) async {
    return await _driveApi!.files.get(fileId, $fields: field) as drive.File;
  }

  /// Copies a file to specified parent folders.
  Future<void> copyFile(String fileId, List<String> parents) async {
    drive.File request = drive.File();
    request.parents = parents;
    await _driveApi!.files.copy(request, fileId);
  }

  /// Deletes a file by its ID.
  Future<void> deleteFile(String fileId) async {
    await _driveApi!.files.delete(fileId);
  }

  /// Uploads a file to Google Drive, updating if it already exists.
  Future<void> uploadFile(String spaces, File file) async {
    final fileId = await getFileId(basename(file.path));

    final driveFile = drive.File();
    driveFile.name = basename(file.path);
    driveFile.mimeType = MimeResolver.lookupAll(file);

    final media = drive.Media(file.openRead(), file.lengthSync());

    if (fileId != null) {
      await _driveApi!.files.update(driveFile, fileId, uploadMedia: media);
    } else {
      driveFile.parents = [spaces];
      await _driveApi!.files.create(driveFile, uploadMedia: media);
    }
  }

  /// Downloads a file from Google Drive and saves it locally.
  Future<void> downloadFile(
    String fileId,
    File saveFile, {
    void Function(int, int)? onDownload,
    void Function()? onDone,
    void Function(Object)? onError,
  }) async {
    final logger = Logger();
    final completer = Completer();
    List<int> buffer = [];

    final fileStat = await instance.getMetadataById(fileId, field: 'size');
    final fileSize = IntUtils.parse(fileStat.size);

    drive.Media media = await instance._driveApi!.files.get(
      fileId,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;

    logger.i('Google Drive Api: Starting file download.');

    media.stream.listen((List<int> data) {
      buffer.addAll(data);
      onDownload?.call(buffer.length, fileSize);
    }, onDone: () {
      saveFile.writeAsBytesSync(buffer);
      buffer.clear();
      completer.complete();
    }, onError: (e) {
      logger.e('Google Drive Api: $e');
      completer.completeError(e);
    });

    await completer.future;

    logger.i('Google Drive Api: Download File Complete.');
    logger.close();
  }
}

/// Exception thrown when Google Drive sign-in fails.
class GoogleDriveSignInException extends ExceptionTemplate {
  @override
  final message = 'Google Drive sign-in failed. Please try again.';
}

/// Exception thrown when Google Drive permissions are denied.
class GoogleDrivePermissionDeniedException implements ExceptionTemplate {
  @override
  final message =
      'Google Drive permissions were denied. Please check your settings and try again.';
}
