import 'dart:async';
import 'dart:convert';

import 'package:novel_glide/features/reader/data/data_transfer_objects/reader_web_message_dto.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/log_system/log_system.dart';
import '../../domain/entities/reader_set_state_data.dart';
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

  final StreamController<ReaderWebMessageDto> _messageStreamController =
      StreamController<ReaderWebMessageDto>.broadcast();
  final StreamController<String> _saveLocationStreamController =
      StreamController<String>.broadcast();
  final StreamController<void> _loadDoneStreamController =
      StreamController<void>.broadcast();
  final StreamController<ReaderSetStateData> _setStateStreamController =
      StreamController<ReaderSetStateData>.broadcast();

  @override
  Stream<ReaderWebMessageDto> get messages => _messageStreamController.stream;

  @override
  Stream<String> get saveLocationStream => _saveLocationStreamController.stream;

  @override
  Stream<void> get loadDoneStream => _loadDoneStreamController.stream;

  @override
  Stream<ReaderSetStateData> get setStateStream =>
      _setStateStreamController.stream;

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

    if (data['route'] is String) {
      LogSystem.info("Reader: Receive - ${data['route']} ${data['data']}");

      _messageDispatcher(ReaderWebMessageDto(
        route: data['route'],
        data: data['data'],
      ));
    }
  }

  void _messageDispatcher(ReaderWebMessageDto message) {
    switch (message.route) {
      case 'saveLocation':
        if (message.data is String) {
          _saveLocationStreamController.add(message.data);
        }
        break;

      case 'loadDone':
        _loadDoneStreamController.add(null);
        break;

      case 'setState':
        if (message.data is Map<String, dynamic>) {
          try {
            _setStateStreamController
                .add(ReaderSetStateData.fromJson(message.data));
          } catch (e) {
            print(e);
          }
        }
        break;
    }
    _messageStreamController.add(message);
  }

  @override
  Future<void> dispose() async {
    await _messageStreamController.close();
    await _saveLocationStreamController.close();
    await _loadDoneStreamController.close();
  }
}
