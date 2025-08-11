import 'dart:typed_data';

import '../../../../core/use_cases/use_case.dart';
import '../repositories/book_repository.dart';

class BookReadBytesUseCase extends UseCase<Future<Uint8List>, String> {
  BookReadBytesUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<Uint8List> call(String parameter) {
    return _repository.readBookBytes(parameter);
  }
}
