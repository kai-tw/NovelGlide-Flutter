import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/book_object.dart';
import '../../../shared/chapter_object.dart';

enum TOCStateCode { unload, loading, normal, empty }

class TOCCubit extends Cubit<TOCState> {
  TOCCubit(this.bookObject) : super(const TOCState());

  BookObject bookObject;

  void refresh() async {
    emit(const TOCState(code: TOCStateCode.loading));
    await Future.delayed(const Duration(seconds: 1));
    List<ChapterObject> chapterList = await bookObject.getChapters();
    TOCStateCode code = chapterList.isEmpty ? TOCStateCode.empty : TOCStateCode.normal;
    emit(TOCState(code: code, chapterList: chapterList));
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
