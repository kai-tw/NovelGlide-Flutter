import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ChapterListStateCode { unload, loading, nothing }

class ChapterListCubit extends Cubit<ChapterListState> {
  ChapterListCubit() : super(const ChapterListState());
}

class ChapterListState extends Equatable {
  final ChapterListStateCode code;
  final List<String> chapterList;
  final Set<int> selectedChapter;
  final Set<int> slidedChapter;

  const ChapterListState({
    this.code = ChapterListStateCode.unload,
    this.chapterList = const [],
    this.selectedChapter = const <int>{},
    this.slidedChapter = const <int>{},
  });

  ChapterListState copyWith(
    ChapterListStateCode? code,
    List<String>? chapterList,
    Set<int>? selectedChapter,
    Set<int>? slidedChapter,
  ) {
    return ChapterListState(
      code: code ?? this.code,
      chapterList: chapterList ?? this.chapterList,
      selectedChapter: selectedChapter ?? this.selectedChapter,
      slidedChapter: slidedChapter ?? this.slidedChapter,
    );
  }

  @override
  List<Object?> get props => [];
}
