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
  }

  Future<void> signIn() async {
    if (!_isInitialized) {
      throw PlatformException(code: ExceptionCode.googleSignInNotInitialized);
    }

    // Login silently first
    _currentUser =
        await GoogleSignIn.instance.attemptLightweightAuthentication();

    // If silent login fails, prompt the user to sign in
    try {
      _currentUser ??= await GoogleSignIn.instance.authenticate();
    } on GoogleSignInException catch (_) {
      throw PlatformException(code: ExceptionCode.googleSignInFailed);
    }

    if (_currentUser == null) {
      throw PlatformException(code: ExceptionCode.googleSignInFailed);
    }
  }

  Future<GoogleAuthClient> getClient(List<String> scopes) async {
    if (!_isInitialized) {
      throw PlatformException(code: ExceptionCode.googleSignInNotInitialized);
    }

    // Attempt to get authorization for the requested scopes
    GoogleSignInClientAuthorization? authorization =
        await _currentUser?.authorizationClient.authorizationForScopes(scopes);

    // If authorization is null, prompt the user to authorize
    authorization ??=
        await _currentUser?.authorizationClient.authorizeScopes(scopes);

    // Cannot get the required scopes
    if (authorization == null) {
      throw PlatformException(code: ExceptionCode.googleDrivePermissionDenied);
    }

    final Map<String, String>? header =
        await _currentUser!.authorizationClient.authorizationHeaders(scopes);

    // Cannot get the header
    if (header == null) {
      throw PlatformException(code: ExceptionCode.googleDrivePermissionDenied);
    }

    return GoogleAuthClient(header);
  }

  Future<void> signOut() async {
    if (!_isInitialized) {
      throw PlatformException(code: ExceptionCode.googleSignInNotInitialized);
    }

    await GoogleSignIn.instance.signOut();
    _currentUser = null;
  }

  Future<void> _handleAuthenticationEvent(
      GoogleSignInAuthenticationEvent event) async {}

  Future<void> _handleAuthenticationError(Object e) async {}
}
