import '../../../../core/use_cases/use_case.dart';
import '../repositories/reader_location_cache_repository.dart';

class ReaderGetLocationCacheUseCase extends UseCase<Future<String?>, String> {
  const ReaderGetLocationCacheUseCase(this._repository);

  final ReaderLocationCacheRepository _repository;

  @override
  Future<String?> call(String parameter) {
    return _repository.get(parameter);
  }
}
