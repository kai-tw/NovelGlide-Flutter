import '../../../../core/use_cases/use_case.dart';
import '../repositories/reader_location_cache_repository.dart';

class ReaderStoreLocationCacheUseCaseParam {
  ReaderStoreLocationCacheUseCaseParam({
    required this.bookIdentifier,
    required this.location,
  });

  final String bookIdentifier;
  final String location;
}

class ReaderStoreLocationCacheUseCase
    extends UseCase<Future<void>, ReaderStoreLocationCacheUseCaseParam> {
  const ReaderStoreLocationCacheUseCase(this._repository);

  final ReaderLocationCacheRepository _repository;

  @override
  Future<void> call(ReaderStoreLocationCacheUseCaseParam parameter) {
    return _repository.store(parameter.bookIdentifier, parameter.location);
  }
}
