import 'dart:async';
import 'dart:io';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:path/path.dart';

import '../toolbox/mime_resolver.dart';

class GoogleDriveApi {
  static GoogleDriveApi get instance => _instance;
  static final GoogleDriveApi _instance = GoogleDriveApi._internal();
  static final List<String> _scopes = [
    drive.DriveApi.driveAppdataScope,
    drive.DriveApi.driveFileScope,
  ];

  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: _scopes);
  drive.DriveApi? driveApi;

  factory GoogleDriveApi() => _instance;

  GoogleDriveApi._internal();

  Future<void> signIn() async {
    if (await _googleSignIn.signInSilently() == null && await _googleSignIn.signIn() == null) {
      throw GoogleDriveSignInException();
    }

    if (!await _googleSignIn.requestScopes(_scopes)) {
      throw GoogleDrivePermissionDeniedException();
    }

    final AuthClient? httpClient = await _googleSignIn.authenticatedClient();

    if (httpClient == null) {
      throw GoogleDriveSignInException();
    } else {
      driveApi = drive.DriveApi(httpClient);
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    driveApi = null;
  }

  Future<bool> isSignedIn() async => await _googleSignIn.isSignedIn() && driveApi != null;

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
    return await driveApi!.files.list(
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

  Future<String?> getDriveFolderId() async {
    return (await driveApi!.files.get('root') as drive.File).id;
  }

  Future<void> copyFile(String fileId, List<String> parents) async {
    drive.File request = drive.File();
    request.parents = parents;
    await driveApi!.files.copy(request, fileId);
  }

  Future<void> deleteFile(String fileId) async {
    await driveApi!.files.delete(fileId);
  }

  Future<void> uploadFile(String spaces, File file) async {
    final drive.FileList fileList =
        await driveApi!.files.list(spaces: spaces, q: "name = '${basename(file.path)}'", pageSize: 1);
    final String? fileId = fileList.files?.isNotEmpty ?? false ? fileList.files?.first.id : null;

    final drive.File driveFile = drive.File();
    driveFile.name = basename(file.path);
    driveFile.parents = [spaces];
    driveFile.mimeType = MimeResolver.instance.lookupAll(file);

    final drive.Media media = drive.Media(file.openRead(), file.lengthSync());

    if (fileId != null) {
      await driveApi!.files.update(driveFile, fileId, uploadMedia: media);
    } else {
      await driveApi!.files.create(driveFile, uploadMedia: media);
    }
  }

  Future<void> downloadFile(String fileId, File saveFile) async {
    Completer completer = Completer();
    List<int> buffer = [];

    drive.Media media = await GoogleDriveApi.instance.driveApi!.files.get(
      fileId,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;

    media.stream.listen((List<int> data) {
      buffer.addAll(data);
    }, onDone: () {
      saveFile.writeAsBytesSync(buffer);
      buffer.clear();
      completer.complete();
    }, onError: (e) {
      FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
    });

    await completer.future;
  }
}

class GoogleDriveSignInException implements Exception {}

class GoogleDrivePermissionDeniedException implements Exception {}
