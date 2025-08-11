import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/ad_repository.dart';

class AdCheckEnabledUseCase extends UseCase<bool, void> {
  AdCheckEnabledUseCase(this._repository);

  final AdRepository _repository;

  @override
  bool call([void parameter]) {
    return _repository.enabled;
  }
}
