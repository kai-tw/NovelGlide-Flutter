import '../../domain/entities/auth_client.dart';
import '../../domain/entities/auth_user.dart';

abstract class AuthApi {
  Future<AuthClient> getClient(List<String> scopes);

  Future<AuthUser> getUser();

  Future<void> signIn();

  Future<void> signOut();
}
