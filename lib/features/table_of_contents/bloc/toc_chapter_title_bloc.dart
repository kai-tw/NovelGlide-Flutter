import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/chapter_data.dart';

class TocChapterTitleCubit extends Cubit<TocChapterTitleState> {
  TocChapterTitleCubit() : super(const TocChapterTitleState());

  void refresh(ChapterData chapterData) async {
    final String title = await chapterData.getTitle();
    if (!isClosed) {
      emit(state.copyWith(chapterNumber: chapterData.ordinalNumber, title: title));
    }
  }
}

class TocChapterTitleState extends Equatable {
  final int chapterNumber;
  final String title;

  @override
  List<Object?> get props => [chapterNumber, title];

  const TocChapterTitleState({
    this.chapterNumber = 0,
    this.title = "",
  });

  TocChapterTitleState copyWith({
    int? chapterNumber,
    String? title,
  }) {
    return TocChapterTitleState(
      chapterNumber: chapterNumber ?? this.chapterNumber,
      title: title ?? this.title,
    );
  }
}
