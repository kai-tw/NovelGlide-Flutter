import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/book_cover.dart';
import '../../../domain/use_cases/book_get_cover_use_case.dart';
import 'book_cover_state.dart';

class BookCoverCubit extends Cubit<BookCoverState> {
  BookCoverCubit(this._bookGetCoverUseCase) : super(const BookCoverState());

  final BookGetCoverUseCase _bookGetCoverUseCase;

  Future<BookCover> startLoading(String identifier) async {
    return await _bookGetCoverUseCase(identifier);
  }
}
