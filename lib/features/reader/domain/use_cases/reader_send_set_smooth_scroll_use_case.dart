import '../../../../core/domain/use_cases/use_case.dart';
import '../../data/data_transfer_objects/reader_web_message_dto.dart';
import '../repositories/reader_web_view_repository.dart';

class ReaderSendSetSmoothScrollUseCase extends UseCase<void, bool> {
  ReaderSendSetSmoothScrollUseCase(this._repository);

  final ReaderWebViewRepository _repository;

  @override
  void call(bool parameter) {
    _repository.send(ReaderWebMessageDto(
      route: 'setSmoothScroll',
      data: parameter,
    ));
  }
}
