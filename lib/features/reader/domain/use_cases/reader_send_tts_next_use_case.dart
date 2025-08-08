import '../../../../core/use_cases/use_case.dart';
import '../../data/data_transfer_objects/reader_web_message_dto.dart';
import '../repositories/reader_web_view_repository.dart';

class ReaderSendTtsNextUseCase extends UseCase<void, void> {
  ReaderSendTtsNextUseCase(this._repository);

  final ReaderWebViewRepository _repository;

  @override
  void call([void parameter]) {
    _repository.send(const ReaderWebMessageDto(route: 'ttsNext'));
  }
}
