import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../data/chapter_data.dart';
import '../../../toolbox/chapter_utility.dart';

enum TOCStateCode { loading, normal, empty }

class TOCCubit extends Cubit<TOCState> {
  final BookData bookObject;

  TOCCubit(this.bookObject) : super(const TOCState());

  void refresh({bool isForce = false}) async {
    List<ChapterData> chapterList = ChapterUtility.getList(bookObject.name);
    TOCStateCode code = chapterList.isEmpty ? TOCStateCode.empty : TOCStateCode.normal;
    for (var e in chapterList) {
      await e.initAsync();
    }
    emit(state.copyWith(flipFlop: isForce ? !state.flipFlop : state.flipFlop, code: code, chapterList: chapterList));
  }

  void setDirty() {
    emit(state.copyWith(isDirty: true));
  }

  void deleteChapter(int chapterNumber) async {
    final bool isSuccess = await ChapterData(bookName: bookObject.name, ordinalNumber: chapterNumber).delete();
    if (isSuccess) {
      refresh();
    }
  }
}

class TOCState extends Equatable {
  final bool flipFlop;
  final bool isDirty;
  final TOCStateCode code;
  final List<ChapterData> chapterList;

  @override
  List<Object?> get props => [flipFlop, isDirty, code, chapterList];

  const TOCState({
    this.flipFlop = false,
    this.isDirty = false,
    this.code = TOCStateCode.loading,
    this.chapterList = const [],
  });

  TOCState copyWith({
    bool? flipFlop,
    bool? isDirty,
    TOCStateCode? code,
    List<ChapterData>? chapterList,
  }) {
    return TOCState(
      flipFlop: flipFlop ?? this.flipFlop,
      isDirty: isDirty ?? this.isDirty,
      code: code ?? this.code,
      chapterList: chapterList ?? this.chapterList,
    );
  }
}
