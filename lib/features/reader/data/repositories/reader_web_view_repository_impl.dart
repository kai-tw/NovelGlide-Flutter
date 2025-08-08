import 'dart:async';
import 'dart:convert';

import 'package:novel_glide/features/reader/data/data_transfer_objects/reader_web_message_dto.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/log_system/log_system.dart';
import '../../domain/repositories/reader_web_view_repository.dart';

class ReaderWebViewRepositoryImpl implements ReaderWebViewRepository {
  factory ReaderWebViewRepositoryImpl(WebViewController controller) {
    final ReaderWebViewRepositoryImpl repository =
        ReaderWebViewRepositoryImpl._(controller);
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.addJavaScriptChannel('appApi',
        onMessageReceived: repository.receive);
    return repository;
  }

  ReaderWebViewRepositoryImpl._(this._controller);

  final WebViewController _controller;

  final StreamController<ReaderWebMessageDto> _streamController =
      StreamController<ReaderWebMessageDto>.broadcast();

  @override
  Stream<ReaderWebMessageDto> get messages => _streamController.stream;

  @override
  void setChannel() {
    _controller
        .runJavaScript('window.communicationService.setChannel(window.appApi)');
  }

  @override
  void send(ReaderWebMessageDto message) {
    _controller.runJavaScript(
        'window.communicationService.receive("${message.route}", '
        '${message.data != null ? jsonEncode(message.data) : 'undefined'})');
  }

  void receive(JavaScriptMessage message) {
    final Map<String, dynamic> data = jsonDecode(message.message);
    assert(data['route'] is String);

    LogSystem.info("Reader: Receive - ${data['route']} ${data['data']}");

    _streamController.add(ReaderWebMessageDto(
      route: data['route'],
      data: data['data'],
    ));
  }

  @override
  Future<void> dispose() async {
    await _streamController.close();
  }
}
