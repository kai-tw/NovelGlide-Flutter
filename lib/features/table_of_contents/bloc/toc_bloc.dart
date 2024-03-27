import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/book_object.dart';
import '../../../shared/chapter_object.dart';
import '../../../shared/chapter_utility.dart';

enum TOCStateCode { unload, loading, normal, empty }

class TOCCubit extends Cubit<TOCState> {
  final BookObject bookObject;

  TOCCubit(this.bookObject) : super(const TOCState());

  void refresh() {
    List<ChapterObject> chapterList = ChapterUtility.getList(bookObject.name);
    TOCStateCode code = chapterList.isEmpty ? TOCStateCode.empty : TOCStateCode.normal;
    emit(state.copyWith(code: code, chapterList: chapterList));
  }
}

class TOCState extends Equatable {
  final TOCStateCode code;
  final List<ChapterObject> chapterList;

  const TOCState({
    this.code = TOCStateCode.unload,
    this.chapterList = const [],
  });

  TOCState copyWith({
    TOCStateCode? code,
    List<ChapterObject>? chapterList,
  }) {
    return TOCState(
      code: code ?? this.code,
      chapterList: chapterList ?? this.chapterList,
    );
  }

  @override
  List<Object?> get props => [code, chapterList];
}
