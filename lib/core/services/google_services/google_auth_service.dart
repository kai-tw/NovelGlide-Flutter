part of 'google_services.dart';

class GoogleAuthService {
  factory GoogleAuthService() {
    final GoogleAuthService instance = GoogleAuthService._();
    GoogleSignIn.instance.initialize().then(instance.onInitialized);
    return instance;
  }

  GoogleAuthService._();

  bool get isSignedIn => _isInitialized && _currentUser != null;

  bool _isInitialized = false;
  GoogleSignInAccount? _currentUser;

  FutureOr<void> onInitialized(void _) {
    _isInitialized = true;

    GoogleSignIn.instance.authenticationEvents
        .listen(_handleAuthenticationEvent)
        .onError(_handleAuthenticationError);
    LogService.info('GoogleAuthService: Initialized.');
  }

  Future<void> signIn() async {
    if (!_isInitialized) {
      LogService.error('GoogleAuthService.signIn: Run before initialization');
      throw PlatformException(code: ExceptionCode.googleSignInNotInitialized);
    }

    LogService.info('GoogleAuthService.signIn: Start');

    // Login silently first
    _currentUser =
        await GoogleSignIn.instance.attemptLightweightAuthentication();

    // If silent login fails, prompt the user to sign in
    try {
      _currentUser ??= await GoogleSignIn.instance.authenticate();
    } on GoogleSignInException catch (e) {
      LogService.error('GoogleAuthService.signIn: $e', error: e);
      throw PlatformException(code: ExceptionCode.googleSignInFailed);
    }

    if (_currentUser == null) {
      LogService.error('GoogleAuthService.signIn: Authentication failed.');
      throw PlatformException(code: ExceptionCode.googleSignInFailed);
    }

    LogService.info('GoogleAuthService.signIn: done.');
  }

  Future<GoogleAuthClient> getClient(List<String> scopes) async {
    if (!_isInitialized) {
      LogService.error(
          'GoogleAuthService.getClient: Run before initialization');
      throw PlatformException(code: ExceptionCode.googleSignInNotInitialized);
    }

    LogService.info('GoogleAuthService.getClient: Start.');

    // Attempt to get authorization for the requested scopes
    GoogleSignInClientAuthorization? authorization =
        await _currentUser?.authorizationClient.authorizationForScopes(scopes);

    // If authorization is null, prompt the user to authorize
    try {
      authorization ??=
          await _currentUser?.authorizationClient.authorizeScopes(scopes);
    } on GoogleSignInException catch (e) {
      LogService.error('GoogleAuthService.getClient: $e');
      throw PlatformException(code: ExceptionCode.googleDrivePermissionDenied);
    }

    // Cannot get the required scopes
    if (authorization == null) {
      LogService.error('GoogleAuthService.getClient: permission denied');
      throw PlatformException(code: ExceptionCode.googleDrivePermissionDenied);
    }

    final Map<String, String>? header =
        await _currentUser!.authorizationClient.authorizationHeaders(scopes);

    // Cannot get the header
    if (header == null) {
      LogService.error('GoogleAuthService.getClient: header is null');
      throw PlatformException(code: ExceptionCode.googleDrivePermissionDenied);
    }

    LogService.info('GoogleAuthService.getClient: done.');
    return GoogleAuthClient(header);
  }

  Future<void> signOut() async {
    if (!_isInitialized) {
      LogService.error('GoogleAuthService.signOut: Run before initialization');
      throw PlatformException(code: ExceptionCode.googleSignInNotInitialized);
    }

    await GoogleSignIn.instance.signOut();
    _currentUser = null;
  }

  Future<void> _handleAuthenticationEvent(
      GoogleSignInAuthenticationEvent event) async {}

  Future<void> _handleAuthenticationError(Object e) async {}
}
