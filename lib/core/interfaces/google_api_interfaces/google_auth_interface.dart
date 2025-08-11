part of 'google_api_interfaces.dart';

class GoogleAuthInterface {
  factory GoogleAuthInterface() {
    final GoogleAuthInterface instance = GoogleAuthInterface._();
    GoogleSignIn.instance.initialize().then((_) {
      LogSystem.info('GoogleAuthService: Initialized.');
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
    LogSystem.info('GoogleAuthService.signIn: Start');

    // Login silently first
    _currentUser =
        await GoogleSignIn.instance.attemptLightweightAuthentication();

    // If silent login fails, prompt the user to sign in
    try {
      _currentUser ??= await GoogleSignIn.instance.authenticate();
    } on GoogleSignInException catch (e, s) {
      LogSystem.error('GoogleAuthService.signIn: $e', error: e, stackTrace: s);
      throw GoogleAuthSignInException();
    }

    if (_currentUser == null) {
      LogSystem.error('GoogleAuthService.signIn: Authentication failed.');
      throw GoogleAuthSignInException();
    }

    LogSystem.info('GoogleAuthService.signIn: done.');
  }

  Future<GoogleAuthClient> getClient(List<String> scopes) async {
    await _initCompleter.future;
    LogSystem.info('GoogleAuthService.getClient: Start.');

    // Attempt to get authorization for the requested scopes
    GoogleSignInClientAuthorization? authorization =
        await _currentUser?.authorizationClient.authorizationForScopes(scopes);

    // If authorization is null, prompt the user to authorize
    try {
      authorization ??=
          await _currentUser?.authorizationClient.authorizeScopes(scopes);
    } on GoogleSignInException catch (e) {
      LogSystem.error('GoogleAuthService.getClient: $e');
      throw GoogleDrivePermissionException();
    }

    // Cannot get the required scopes
    if (authorization == null) {
      LogSystem.error('GoogleAuthService.getClient: permission denied');
      throw GoogleDrivePermissionException();
    }

    final Map<String, String>? header =
        await _currentUser!.authorizationClient.authorizationHeaders(scopes);

    // Cannot get the header
    if (header == null) {
      LogSystem.error('GoogleAuthService.getClient: header is null');
      throw GoogleDrivePermissionException();
    }

    LogSystem.info('GoogleAuthService.getClient: done.');
    return GoogleAuthClient(header);
  }

  Future<void> signOut() async {
    await _initCompleter.future;
    await GoogleSignIn.instance.signOut();
    _currentUser = null;
  }
}
