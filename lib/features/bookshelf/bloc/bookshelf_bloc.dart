import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../processor/book_processor.dart';

enum BookshelfStateCode { normal, selecting, empty, loading }

class BookshelfCubit extends Cubit<BookshelfState> {
  BookshelfCubit() : super(const BookshelfState());

  void refresh() {
    List<BookData> list = BookProcessor.getDataList();
    BookshelfStateCode code = list.isEmpty ? BookshelfStateCode.empty : BookshelfStateCode.normal;
    emit(BookshelfState(code: code, bookList: list));
  }
}

class BookshelfState extends Equatable {
  final BookshelfStateCode code;
  final List<BookData> bookList;

  @override
  List<Object?> get props => [code, bookList];

  const BookshelfState({
    this.code = BookshelfStateCode.loading,
    this.bookList = const [],
  });

  BookshelfState copyWith({
    BookshelfStateCode? code,
    List<BookData>? bookList,
    bool? refreshTrigger,
  }) {
    return BookshelfState(
      code: code ?? this.code,
      bookList: bookList ?? this.bookList,
    );
  }
}
