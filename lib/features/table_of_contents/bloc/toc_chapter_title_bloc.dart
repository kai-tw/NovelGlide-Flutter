import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/chapter_data.dart';

class TOCChapterTitleCubit extends Cubit<TOCChapterTitleState> {
  TOCChapterTitleCubit() : super(const TOCChapterTitleState());

  void refresh(ChapterData chapterData) async {
    final String title = await chapterData.getTitle();
    if (!isClosed) {
      emit(state.copyWith(chapterNumber: chapterData.ordinalNumber, title: title));
    }
  }
}

class TOCChapterTitleState extends Equatable {
  final int chapterNumber;
  final String title;

  @override
  List<Object?> get props => [chapterNumber, title];

  const TOCChapterTitleState({
    this.chapterNumber = 0,
    this.title = "",
  });

  TOCChapterTitleState copyWith({
    int? chapterNumber,
    String? title,
  }) {
    return TOCChapterTitleState(
      chapterNumber: chapterNumber ?? this.chapterNumber,
      title: title ?? this.title,
    );
  }
}
