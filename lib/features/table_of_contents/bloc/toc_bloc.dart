import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../data/chapter_data.dart';
import '../../../processor/book_processor.dart';
import '../../../processor/chapter_processor.dart';

enum TOCStateCode { loading, normal, empty }

class TOCCubit extends Cubit<TOCState> {
  TOCCubit(BookData bookData) : super(TOCState(bookName: bookData.name));

  void refresh({BookData? newData}) async {
    final String bookName = newData?.name ?? state.bookName;
    final List<ChapterData> chapterList = ChapterProcessor.getList(bookName);
    final TOCStateCode code = chapterList.isEmpty ? TOCStateCode.empty : TOCStateCode.normal;
    emit(state.copyWith(
      bookName: bookName,
      isCoverExist: BookProcessor.isCoverExist(bookName),
      code: code,
      chapterList: chapterList,
    ));
  }

  void setDirty() {
    emit(state.copyWith(isDirty: true));
  }

  void deleteChapter(int chapterNumber) async {
    final bool isSuccess = await ChapterProcessor.delete(state.bookName, chapterNumber);
    if (isSuccess) {
      refresh();
    }
  }
}

class TOCState extends Equatable {
  final bool isDirty;
  final String bookName;
  final bool isCoverExist;
  final TOCStateCode code;
  final List<ChapterData> chapterList;

  @override
  List<Object?> get props => [isDirty, bookName, isCoverExist, code, chapterList];

  const TOCState({
    this.isDirty = false,
    this.bookName = "",
    this.isCoverExist = false,
    this.code = TOCStateCode.loading,
    this.chapterList = const [],
  });

  TOCState copyWith({
    bool? isDirty,
    String? bookName,
    bool? isCoverExist,
    TOCStateCode? code,
    List<ChapterData>? chapterList,
  }) {
    return TOCState(
      isDirty: isDirty ?? this.isDirty,
      bookName: bookName ?? this.bookName,
      isCoverExist: isCoverExist ?? this.isCoverExist,
      code: code ?? this.code,
      chapterList: chapterList ?? this.chapterList,
    );
  }
}
