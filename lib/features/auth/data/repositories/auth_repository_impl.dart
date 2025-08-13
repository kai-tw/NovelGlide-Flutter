import '../../../../main.dart';
import '../../domain/entities/auth_client.dart';
import '../../domain/entities/auth_providers.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<AuthClient> getClient(
    AuthProviders provider,
    List<String> scopes,
  ) async {
    final AuthApi authApi = sl<AuthApi>(param1: provider);
    return await authApi.getClient(scopes);
  }

  @override
  Future<AuthUser> getUser(AuthProviders provider) async {
    final AuthApi authApi = sl<AuthApi>(param1: provider);
    return await authApi.getUser();
  }

  @override
  Future<void> signIn(AuthProviders provider) async {
    final AuthApi authApi = sl<AuthApi>(param1: provider);
    await authApi.signIn();
  }

  @override
  Future<void> signOut(AuthProviders provider) async {
    final AuthApi authApi = sl<AuthApi>(param1: provider);
    await authApi.signOut();
  }
}
