import 'dart:async';

import '../../domain/entities/reader_search_result_data.dart';
import '../../domain/repositories/reader_search_repository.dart';
import '../../domain/repositories/reader_web_view_repository.dart';
import '../data_transfer_objects/reader_web_message_dto.dart';

class ReaderSearchRepositoryImpl implements ReaderSearchRepository {
  factory ReaderSearchRepositoryImpl(
    ReaderWebViewRepository webViewRepository,
  ) {
    final ReaderSearchRepositoryImpl instance = ReaderSearchRepositoryImpl._();

    instance._messageSubscription =
        webViewRepository.messages.listen(instance._onMessageReceived);

    return instance;
  }

  ReaderSearchRepositoryImpl._();

  late final StreamSubscription<ReaderWebMessageDto> _messageSubscription;

  final StreamController<List<ReaderSearchResultData>> _listController =
      StreamController<List<ReaderSearchResultData>>.broadcast();

  void _onMessageReceived(ReaderWebMessageDto message) {
    switch (message.route) {
      case 'setSearchResultList':
        assert(message.data is List<Map<String, dynamic>>);
        final List<Map<String, dynamic>> rawList =
            message.data as List<Map<String, dynamic>>;
        _listController.add(rawList
            .map((Map<String, dynamic> e) => ReaderSearchResultData(
                  cfi: e['cfi'],
                  excerpt: e['excerpt'],
                ))
            .toList());
        break;
    }
  }

  @override
  Future<void> dispose() async {
    await _messageSubscription.cancel();
    await _listController.close();
  }

  /// Streams

  @override
  Stream<List<ReaderSearchResultData>> get resultListStream =>
      _listController.stream;
}
