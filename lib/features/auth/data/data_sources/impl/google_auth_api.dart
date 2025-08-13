import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/log_system/log_system.dart';
import '../../../../../core/services/exception_service/exception_service.dart';
import '../../../domain/entities/auth_client.dart';
import '../../../domain/entities/auth_user.dart';
import '../auth_api.dart';

class GoogleAuthApi implements AuthApi {
  factory GoogleAuthApi() {
    final GoogleAuthApi instance = GoogleAuthApi._();
    GoogleSignIn.instance.initialize().then((_) {
      instance._initCompleter.complete();
      LogSystem.info('GoogleAuthService: Initialized.');
    });
    return instance;
  }

  GoogleAuthApi._();

  final Completer<void> _initCompleter = Completer<void>();
  GoogleSignInAccount? _currentUser;

  @override
  Future<AuthClient> getClient(List<String> scopes) async {
    await _initCompleter.future;

    if (_currentUser == null) {
      // User didn't sign in. Sign in first.
      await signIn();
    }

    LogSystem.info('GoogleAuthService.getClient: Start.');

    final Map<String, String>? header =
        await _currentUser?.authorizationClient.authorizationHeaders(scopes);

    // Cannot get the header
    if (header == null) {
      LogSystem.error('GoogleAuthService.getClient: header is null');
      throw GoogleDrivePermissionException();
    }

    LogSystem.info('GoogleAuthService.getClient: done.');
    return AuthClient(header);
  }

  @override
  Future<AuthUser> getUser() async {
    await _initCompleter.future;

    if (_currentUser == null) {
      // User didn't sign in. Sign in first.
      await signIn();
    }

    return AuthUser(
      displayName: _currentUser?.displayName ?? '',
      email: _currentUser?.email ?? '',
      photoUrl: _currentUser?.photoUrl ?? '',
    );
  }

  @override
  Future<void> signIn() async {
    await _initCompleter.future;
    LogSystem.info('GoogleAuthService.signIn: Start');

    try {
      // Login silently first
      _currentUser =
          await GoogleSignIn.instance.attemptLightweightAuthentication();

      // If silent login fails, prompt the user to sign in
      _currentUser ??= await GoogleSignIn.instance.authenticate();
    } on GoogleSignInException catch (e, s) {
      LogSystem.error('GoogleAuthService.signIn: $e', error: e, stackTrace: s);
      throw GoogleAuthSignInException();
    }

    // It cannot get the account details.
    if (_currentUser == null) {
      LogSystem.error('GoogleAuthService.signIn: Authentication failed.');
      throw GoogleAuthSignInException();
    }

    LogSystem.info('GoogleAuthService.signIn: done.');
  }

  @override
  Future<void> signOut() async {
    await _initCompleter.future;
    await GoogleSignIn.instance.signOut();
    _currentUser = null;
  }
}
