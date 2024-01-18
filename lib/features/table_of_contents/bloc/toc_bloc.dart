import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/book_process.dart';

enum TOCStateCode { unload, loading, normal, empty }

class TOCCubit extends Cubit<TOCState> {
  TOCCubit(this.bookObject) : super(const TOCState());

  BookObject bookObject;

  void refresh() async {
    emit(const TOCState(code: TOCStateCode.loading));
    Map<int, String> chapterList = await bookObject.getChapters();
    TOCStateCode code = chapterList.isEmpty ? TOCStateCode.empty : TOCStateCode.normal;
    emit(TOCState(code: code, chapterMap: chapterList));
  }
}

class TOCState extends Equatable {
  final TOCStateCode code;
  final Map<int, String> chapterMap;

  const TOCState({
    this.code = TOCStateCode.unload,
    this.chapterMap = const {},
  });

  @override
  List<Object?> get props => [code, chapterMap];
}
