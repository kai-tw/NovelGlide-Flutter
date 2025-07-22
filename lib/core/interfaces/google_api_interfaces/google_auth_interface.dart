part of 'google_api_interfaces.dart';

class GoogleAuthInterface {
  factory GoogleAuthInterface() {
    final GoogleAuthInterface instance = GoogleAuthInterface._();
    GoogleSignIn.instance.initialize().then((_) {
      LogDomain.info('GoogleAuthService: Initialized.');
      instance._initCompleter.complete();
    });
    return instance;
  }

  GoogleAuthInterface._();

  final Completer<void> _initCompleter = Completer<void>();
  GoogleSignInAccount? _currentUser;

  bool get isSignedIn => _currentUser != null;

  Future<void> signIn() async {
    await _initCompleter.future;
    LogDomain.info('GoogleAuthService.signIn: Start');

    // Login silently first
    _currentUser =
        await GoogleSignIn.instance.attemptLightweightAuthentication();

    // If silent login fails, prompt the user to sign in
    try {
      _currentUser ??= await GoogleSignIn.instance.authenticate();
    } on GoogleSignInException catch (e) {
      LogDomain.error('GoogleAuthService.signIn: $e', error: e);
      throw PlatformException(code: ExceptionCode.googleSignInFailed);
    }

    if (_currentUser == null) {
      LogDomain.error('GoogleAuthService.signIn: Authentication failed.');
      throw PlatformException(code: ExceptionCode.googleSignInFailed);
    }

    LogDomain.info('GoogleAuthService.signIn: done.');
  }

  Future<GoogleAuthClient> getClient(List<String> scopes) async {
    await _initCompleter.future;
    LogDomain.info('GoogleAuthService.getClient: Start.');

    // Attempt to get authorization for the requested scopes
    GoogleSignInClientAuthorization? authorization =
        await _currentUser?.authorizationClient.authorizationForScopes(scopes);

    // If authorization is null, prompt the user to authorize
    try {
      authorization ??=
          await _currentUser?.authorizationClient.authorizeScopes(scopes);
    } on GoogleSignInException catch (e) {
      LogDomain.error('GoogleAuthService.getClient: $e');
      throw PlatformException(code: ExceptionCode.googleDrivePermissionDenied);
    }

    // Cannot get the required scopes
    if (authorization == null) {
      LogDomain.error('GoogleAuthService.getClient: permission denied');
      throw PlatformException(code: ExceptionCode.googleDrivePermissionDenied);
    }

    final Map<String, String>? header =
        await _currentUser!.authorizationClient.authorizationHeaders(scopes);

    // Cannot get the header
    if (header == null) {
      LogDomain.error('GoogleAuthService.getClient: header is null');
      throw PlatformException(code: ExceptionCode.googleDrivePermissionDenied);
    }

    LogDomain.info('GoogleAuthService.getClient: done.');
    return GoogleAuthClient(header);
  }

  Future<void> signOut() async {
    await _initCompleter.future;
    await GoogleSignIn.instance.signOut();
    _currentUser = null;
  }
}
