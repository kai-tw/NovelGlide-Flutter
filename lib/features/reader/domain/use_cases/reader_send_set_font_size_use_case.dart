import '../../../../core/domain/use_cases/use_case.dart';
import '../../data/data_transfer_objects/reader_web_message_dto.dart';
import '../repositories/reader_web_view_repository.dart';

class ReaderSendSetFontSizeUseCase extends UseCase<void, double> {
  ReaderSendSetFontSizeUseCase(this._repository);

  final ReaderWebViewRepository _repository;

  @override
  void call(double parameter) {
    _repository.send(ReaderWebMessageDto(
      route: 'setFontSize',
      data: parameter,
    ));
  }
}
