import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/book_process.dart';

enum TOCStateCode { unload, loading, normal, empty }

class TOCCubit extends Cubit<TOCState> {
  TOCCubit(this.bookObject) : super(const TOCState());

  BookObject bookObject;

  void refresh() async {
    emit(const TOCState(code: TOCStateCode.loading));
    List<String> chapterList = await bookObject.getChapters();
    TOCStateCode code = chapterList.isEmpty ? TOCStateCode.empty : TOCStateCode.normal;
    emit(TOCState(code: code, chapterList: chapterList));
  }
}

class TOCState extends Equatable {
  final TOCStateCode code;
  final List<String> chapterList;

  const TOCState({
    this.code = TOCStateCode.unload,
    this.chapterList = const [],
  });

  @override
  List<Object?> get props => [code, chapterList];
}
