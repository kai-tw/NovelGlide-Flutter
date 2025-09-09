import '../../data/data_transfer_objects/reader_web_message_dto.dart';
import '../entities/reader_set_state_data.dart';

abstract class ReaderWebViewRepository {
  // Stream all messages.
  Stream<ReaderWebMessageDto> get messages;

  // Stream the location generated from epub.js.
  Stream<String> get saveLocationStream;

  // Stream the load done event.
  Stream<void> get loadDoneStream;

  // Stream the set state data
  Stream<ReaderSetStateData> get setStateStream;

  void setChannel();

  void send(ReaderWebMessageDto message);

  Future<void> dispose();
}
