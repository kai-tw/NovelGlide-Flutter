import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/reader_web_view_repository.dart';

class ReaderObserveSaveLocationUseCase extends UseCase<Stream<String>, void> {
  ReaderObserveSaveLocationUseCase(this._repository);

  final ReaderWebViewRepository _repository;

  @override
  Stream<String> call([void parameter]) {
    return _repository.saveLocationStream;
  }
}
