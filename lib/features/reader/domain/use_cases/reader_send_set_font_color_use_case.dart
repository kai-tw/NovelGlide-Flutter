import 'package:flutter/material.dart';

import '../../../../core/domain/use_cases/use_case.dart';
import '../../../../core/utils/color_extension.dart';
import '../../data/data_transfer_objects/reader_web_message_dto.dart';
import '../repositories/reader_web_view_repository.dart';

class ReaderSendSetFontColorUseCase extends UseCase<void, Color> {
  ReaderSendSetFontColorUseCase(this._repository);

  final ReaderWebViewRepository _repository;

  @override
  void call(Color color) {
    _repository.send(ReaderWebMessageDto(
      route: 'setFontColor',
      data: color.toCssRgba(),
    ));
  }
}
