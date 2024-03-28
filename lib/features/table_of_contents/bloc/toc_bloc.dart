import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/book_object.dart';
import '../../../shared/chapter_object.dart';
import '../../../shared/chapter_utility.dart';

enum TOCStateCode { loading, normal, empty }

class TOCCubit extends Cubit<TOCState> {
  final BookObject bookObject;
  bool isDirty = false;

  TOCCubit(this.bookObject) : super(const TOCState());

  void refresh({bool isForce = false}) {
    List<ChapterObject> chapterList = ChapterUtility.getList(bookObject.name);
    TOCStateCode code = chapterList.isEmpty ? TOCStateCode.empty : TOCStateCode.normal;
    emit(TOCState(flipFlop: isForce ? !state.flipFlop : state.flipFlop,code: code, chapterList: chapterList));
  }

  void deleteChapter(int chapterNumber) async {
    final bool isSuccess = await ChapterObject(bookName: bookObject.name, ordinalNumber: chapterNumber).delete();
    if (isSuccess) {
      refresh();
    }
  }
}

class TOCState extends Equatable {
  final bool flipFlop;
  final TOCStateCode code;
  final List<ChapterObject> chapterList;

  @override
  List<Object?> get props => [flipFlop, code, chapterList];

  const TOCState({
    this.flipFlop = false,
    this.code = TOCStateCode.loading,
    this.chapterList = const [],
  });
}
