import '../../data/data_transfer_objects/reader_web_message_dto.dart';

abstract class ReaderWebViewRepository {
  Stream<ReaderWebMessageDto> get messages;
  void setChannel();
  void send(ReaderWebMessageDto message);
  Future<void> dispose();
}
