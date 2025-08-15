import '../entities/auth_client.dart';
import '../entities/auth_providers.dart';
import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<bool> isSignIn(AuthProviders provider);

  Future<AuthClient> getClient(AuthProviders provider, List<String> scopes);

  Future<AuthUser> getUser(AuthProviders provider);

  Future<void> signIn(AuthProviders provider);

  Future<void> signOut(AuthProviders provider);
}
