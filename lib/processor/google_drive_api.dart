import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

class GoogleDriveApi {
  static GoogleDriveApi get instance => _instance;
  static final GoogleDriveApi _instance = GoogleDriveApi._internal();
  static final List<String> _scopes = [
    DriveApi.driveAppdataScope,
    DriveApi.driveFileScope,
  ];

  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: _scopes);
  DriveApi? driveApi;

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
      driveApi = DriveApi(httpClient);
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    driveApi = null;
  }

  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn() && driveApi != null;
  }
}

class GoogleDriveSignInException implements Exception {}
class GoogleDrivePermissionDeniedException implements Exception {}
