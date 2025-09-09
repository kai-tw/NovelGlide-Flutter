import 'dart:async';

import '../../domain/repositories/reader_tts_repository.dart';
import '../../domain/repositories/reader_web_view_repository.dart';
import '../data_transfer_objects/reader_web_message_dto.dart';

class ReaderTtsRepositoryImpl extends ReaderTtsRepository {
  factory ReaderTtsRepositoryImpl(ReaderWebViewRepository webViewRepository) {
    final ReaderTtsRepositoryImpl instance = ReaderTtsRepositoryImpl._();

    instance._messageSubscription =
        webViewRepository.messages.listen(instance._messageDispatcher);

    return instance;
  }

  ReaderTtsRepositoryImpl._();

  // Stream controllers
  final StreamController<void> _ttsEndController =
      StreamController<void>.broadcast();
  final StreamController<String> _ttsPlayController =
      StreamController<String>.broadcast();
  final StreamController<void> _ttsStopController =
      StreamController<void>.broadcast();

  // Stream subscription
  late final StreamSubscription<ReaderWebMessageDto> _messageSubscription;

  // Message dispatcher
  void _messageDispatcher(ReaderWebMessageDto message) {
    switch (message.route) {
      case 'ttsEnd':
        _ttsEndController.add(null);
        break;

      case 'ttsPlay':
        if (message.data is String) {
          _ttsPlayController.add(message.data);
        }
        break;

      case 'ttsStop':
        _ttsStopController.add(null);
        break;
    }
  }

  /// Streams

  @override
  Stream<void> get ttsEndStream => _ttsEndController.stream;

  @override
  Stream<String> get ttsPlayStream => _ttsPlayController.stream;

  @override
  Stream<void> get ttsStopStream => _ttsStopController.stream;

  @override
  Future<void> dispose() async {
    await _messageSubscription.cancel();
    await _ttsEndController.close();
    await _ttsPlayController.close();
    await _ttsStopController.close();
  }
}
