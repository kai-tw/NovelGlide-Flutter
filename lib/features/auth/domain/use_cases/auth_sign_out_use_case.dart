import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/auth_providers.dart';
import '../repositories/auth_repository.dart';

class AuthSignOutUseCase extends UseCase<Future<void>, AuthProviders> {
  const AuthSignOutUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<void> call(AuthProviders parameter) {
    return _repository.signOut(parameter);
  }
}
