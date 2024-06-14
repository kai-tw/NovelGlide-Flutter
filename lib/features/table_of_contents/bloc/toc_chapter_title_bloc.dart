import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/chapter_data.dart';

class TOCChapterTitleCubit extends Cubit<TOCChapterTitleState> {
  final ChapterData chapterData;

  TOCChapterTitleCubit(this.chapterData) : super(const TOCChapterTitleState());

  void initializeAsync() async {
    final String title = await chapterData.getTitleFromCache();
    emit(state.copyWith(chapterNumber: chapterData.ordinalNumber, title: title));
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
