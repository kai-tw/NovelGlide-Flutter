import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/book_object.dart';
import '../../../shared/chapter_object.dart';

enum TOCStateCode { unload, loading, normal, empty }

class TOCCubit extends Cubit<TOCState> {
  final BookObject _bookObject;

  TOCCubit(this._bookObject) : super(TOCState(bookObject: _bookObject));

  void refresh() async {
    emit(state.copyWith(code: TOCStateCode.loading));
    List<ChapterObject> chapterList = await state.bookObject.getChapterList();
    TOCStateCode code = chapterList.isEmpty ? TOCStateCode.empty : TOCStateCode.normal;
    emit(state.copyWith(code: code, chapterList: chapterList));
  }
}

class TOCState extends Equatable {
  final TOCStateCode code;
  final BookObject bookObject;
  final List<ChapterObject> chapterList;

  const TOCState({
    required this.bookObject,
    this.code = TOCStateCode.unload,
    this.chapterList = const [],
  });

  TOCState copyWith({
    TOCStateCode? code,
    List<ChapterObject>? chapterList,
  }) {
    return TOCState(
      bookObject: bookObject,
      code: code ?? this.code,
      chapterList: chapterList ?? this.chapterList,
    );
  }

  @override
  List<Object?> get props => [code, chapterList];
}
