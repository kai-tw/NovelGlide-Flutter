import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/auth_providers.dart';
import '../repositories/auth_repository.dart';

class AuthIsSignInUseCase extends UseCase<Future<bool>, AuthProviders> {
  const AuthIsSignInUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<bool> call(AuthProviders parameter) {
    return _repository.isSignIn(parameter);
  }
}
